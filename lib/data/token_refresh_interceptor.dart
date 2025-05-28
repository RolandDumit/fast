import 'package:dio/dio.dart';
import 'package:fast/extensions/response_extensions.dart';
import 'package:flutter/widgets.dart';

typedef RefreshTokenCallback = Future<String?> Function();
typedef AccessTokenCallback = Future<String?> Function(dynamic responseData);

/// An interceptor for Dio that handles token refresh logic.
/// It intercepts requests and responses to check for 401 Unauthorized errors.
/// This interceptor will automatically retry requests after a successful token refresh.
///
/// Pass the same [Dio] instance on which you added this interceptor.
/// The [refreshTokenUrl] is needed to make the request to refresh the tokens.
/// The [refreshMethod] is the HTTP method to use for the token refresh request, defaulting to 'POST'.
/// The [refreshData] is the data to send with the token refresh request, if any.
///
/// The [onTokensRefreshed] callback is called with the response data from the token refresh request. Used to both pass outside
/// the new tokens and to receive the new access token back. The responsability of reading the new access token from the response
/// is on the caller of this interceptor since the response format is not known.
///
/// The [passRefreshToken] callback is used to retrieve the current refresh token from the caller of this interceptor.
///
/// The [onRefreshFailed] callback is called when the token refresh fails, allowing you to handle the failure case (e.g., redirecting to login).
///
/// {@tool snippet}
///
/// ```dart
/// Dio dio = Dio();
/// dio.interceptors.add(TokenRefreshInterceptor(
///     dio: dio,
///     refreshTokenUrl: 'https://example.com/api/refresh-token',
///     refreshMethod: 'POST',
///     onTokensRefreshed: (responseData) async {
///         // Extract the new access token from the response data
///         return responseData['access_token'];
///     },
///     passRefreshToken: () async {
///         // Retrieve the current refresh token from secure storage or state
///         return 'your_refresh_token';
///     },
///     refreshData: {
///         'refresh_token': 'your_refresh
///     },
///     onRefreshFailed: () {
///         // Handle the case when token refresh fails, e.g., redirect to login
///         print('Token refresh failed, redirecting to login...');
///     },
///  }));
/// ```
/// {@end-tool}
///
class TokenRefreshInterceptor extends Interceptor {
  /// The Dio instance on which this interceptor is added.
  final Dio _dio;

  /// The URL to request for refreshing the token.
  final String refreshTokenUrl;

  /// The HTTP method to use for the token refresh request, defaulting to 'POST'.
  final String refreshMethod;

  /// The data to send with the token refresh request, if any.
  final dynamic refreshData;

  /// Callback to handle the response from the token refresh request.
  final AccessTokenCallback onTokensRefreshed;

  /// Callback to retrieve the current refresh token.
  final RefreshTokenCallback passRefreshToken;

  /// Callback to handle the case when token refresh fails.
  final VoidCallback? onRefreshFailed;

  /// Indicates whether a token refresh is currently in progress.
  bool _isRefreshing = false;

  /// Queue for requests that encountered a 401 Unauthorized error while the token is being refreshed.
  final List<({RequestOptions requestOptions, ErrorInterceptorHandler handler})> _errorRequestQueue = [];

  /// Queue for requests that are pending while the token is being refreshed.
  final List<({RequestOptions requestOptions, RequestInterceptorHandler handler})> _pendingRequestQueue = [];

  /// Creates a new instance of [TokenRefreshInterceptor].
  TokenRefreshInterceptor({
    required Dio dio,
    required this.refreshTokenUrl,
    required this.onTokensRefreshed,
    required this.passRefreshToken,
    this.refreshMethod = 'POST',
    this.refreshData,
    this.onRefreshFailed,
  }) : _dio = dio;

  /// Intercept requests before they are sent.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // If we are refreshing tokens, add the request to the pending queue
    if (_isRefreshing) {
      _pendingRequestQueue.add((requestOptions: options, handler: handler));
      return;
    }

    super.onRequest(options, handler);
  }

  /// Intercept errors after they are received.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401) {
      // If we are already refreshing, add the request to the queue
      if (_isRefreshing) {
        _errorRequestQueue.add((requestOptions: err.requestOptions, handler: handler));
        return;
      }

      _isRefreshing = true;

      // Get the refresh token or handle the case where it is not available
      final refreshToken = await passRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        _isRefreshing = false;
        onRefreshFailed?.call();
        _clearQueueAndReject(err);
        return handler.reject(err);
      }

      try {
        // Use a new Dio instance for token refresh to avoid interceptor loop
        final refreshDio = Dio();
        final uri = Uri.tryParse(refreshTokenUrl);
        // final response = await refreshDio.fetch(err.requestOptions);
        if (uri == null) {
          _isRefreshing = false;
          onRefreshFailed?.call();
          _clearQueueAndReject(err);
          return handler.reject(err);
        }
        final refreshResponse = await refreshDio.fetch(RequestOptions(
          baseUrl: '${uri.scheme}://${uri.host}',
          path: uri.path,
          method: refreshMethod,
          data: refreshData,
        ));

        if (refreshResponse.isSuccessful && refreshResponse.data != null) {
          final newAccessToken = await onTokensRefreshed(refreshResponse.data);
          _isRefreshing = false;

          // Retry the original request
          // err.requestOptions
          try {
            final originalRequestResponse = await _dio.fetch(err.requestOptions);
            handler.resolve(originalRequestResponse);
          } catch (error) {
            handler.reject(
              error is DioException
                  ? error
                  : DioException(
                      requestOptions: err.requestOptions,
                      error: error,
                    ),
            );
          }

          // Retry queued requests
          await _retryQueuedRequests(newAccessToken);
        } else {
          // Refresh failed
          await _handleRefreshFailure(
            err,
            handler,
            DioException(requestOptions: RequestOptions(path: refreshTokenUrl), response: refreshResponse),
          );
        }
      } catch (error) {
        await _handleRefreshFailure(
          err,
          handler,
          error is DioException
              ? error
              : DioException(requestOptions: RequestOptions(path: refreshTokenUrl), error: error),
        );
      } finally {
        // Ensure _isRefreshing is reset if an unexpected error occurred above
        // and wasn't handled by success/failure paths leading to _isRefreshing = false.
        if (_isRefreshing) {
          _isRefreshing = false;
          _clearQueueAndReject(err);
        }
      }
    } else {
      // Not a 401 error, proceed normally
      return handler.next(err);
    }
  }

  /// Clear the error and pending request queues and reject all queued requests.
  _clearQueueAndReject(DioException originalErrorTriggeringRefresh) {
    for (var queuedRequest in _errorRequestQueue) {
      queuedRequest.handler.reject(
        DioException(
          requestOptions: queuedRequest.requestOptions,
          error: "Token refresh failed, request cancelled.",
          response: originalErrorTriggeringRefresh.response, // Can provide original response for context
          type: DioExceptionType.cancel,
        ),
      );
    }
    _errorRequestQueue.clear();
    _pendingRequestQueue.clear();
  }

  /// Retry all queued requests with the new access token.
  _retryQueuedRequests(String? newAccessToken) async {
    final List<({RequestOptions requestOptions, ErrorInterceptorHandler handler})> localErrorQueue =
        List.from(_errorRequestQueue);
    final List<({RequestOptions requestOptions, RequestInterceptorHandler handler})> localPendingQueue =
        List.from(_pendingRequestQueue);

    _errorRequestQueue.clear();
    _pendingRequestQueue.clear();

    await Future.wait([
      for (var queuedRequest in localErrorQueue)
        _dio.fetch(queuedRequest.requestOptions).then(
              (response) => queuedRequest.handler.resolve(response),
              onError: (e) => queuedRequest.handler.reject(
                e is DioException ? e : DioException(requestOptions: queuedRequest.requestOptions, error: e),
              ),
            ),
      for (var queuedRequest in localPendingQueue)
        _dio.fetch(queuedRequest.requestOptions).then(
              (response) => queuedRequest.handler.resolve(response),
              onError: (e) => queuedRequest.handler.reject(
                e is DioException ? e : DioException(requestOptions: queuedRequest.requestOptions, error: e),
              ),
            ),
    ]);
  }

  /// Handle the case when token refresh fails.
  _handleRefreshFailure(
    DioException originalError,
    ErrorInterceptorHandler originalHandler,
    DioException? refreshErrorDetails,
  ) async {
    _isRefreshing = false;
    _clearQueueAndReject(originalError); // Reject queued requests
    onRefreshFailed?.call();
    originalHandler.reject(refreshErrorDetails ?? originalError); // Reject the original request
  }
}
