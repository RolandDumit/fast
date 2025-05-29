import 'package:dio/dio.dart';
import 'package:fast/enums/enums.dart';
import 'package:fast/extensions/response_extensions.dart';
import 'package:fast/utils/failures.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkDatasource {
  final bool prettyPrint;
  late final Dio _dioClient;

  // Private static instance of the singleton.
  static NetworkDatasource _instance({
    bool prettyPrint = true,
    BaseOptions? options,
    List<Interceptor>? interceptors,
  }) =>
      NetworkDatasource._internal(
        prettyPrint: prettyPrint,
        options: options,
        interceptors: interceptors,
      );

  // Private named constructor.
  NetworkDatasource._internal({
    this.prettyPrint = true,
    BaseOptions? options,
    List<Interceptor>? interceptors,
  }) {
    _dioClient = Dio(options);

    // Add interceptors to the client if any
    _dioClient.interceptors.addAll([
      if (prettyPrint) PrettyDioLogger(),
      ...interceptors ?? [],
    ]);
  }

  // Factory constructor that returns the same instance every time.
  factory NetworkDatasource({
    bool prettyPrint = true,
    BaseOptions? options,
    List<Interceptor>? interceptors,
  }) =>
      _instance(
        prettyPrint: prettyPrint,
        options: options,
        interceptors: interceptors,
      );

  /// Fetch data from the network
  Future<Result<dynamic, RequestFailure>> fetchData({
    required HttpMethods httpMethod,
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? receiveDataWhenStatusError,
    ResponseType? responseType,
    String? contentType,
    ValidateStatus? validateStatus,
    int? maxRedirects,
    bool? followRedirects,
    RequestEncoder? requestEncoder,
    ResponseDecoder? responseDecoder,
    ListFormat? listFormat,
    StackTrace? sourceStackTrace,
  }) async {
    try {
      // Request options
      final requestOptions = RequestOptions(
        path: path,
        data: data,
        headers: headers,
        queryParameters: queryParameters,
        method: httpMethod.value,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        receiveDataWhenStatusError: receiveDataWhenStatusError,
        responseType: responseType,
        contentType: contentType,
        validateStatus: validateStatus,
        maxRedirects: maxRedirects,
        followRedirects: followRedirects,
        requestEncoder: requestEncoder,
        responseDecoder: responseDecoder,
        listFormat: listFormat,
        sourceStackTrace: sourceStackTrace,
      );

      // Api call
      final response = await _dioClient.fetch(requestOptions);

      if (response.isSuccessful) {
        return Result.success(response.data);
      } else {
        return Result.error(RequestNotSuccessfulFailure(response.statusMessage, response: response));
      }
    } on DioException catch (error) {
      // Handle Dio exceptions
      return Result.error(DioExceptionFailure(error.message, dioException: error));
    } catch (error) {
      // Handle generic exceptions
      return Result.error(GenericRequestFailure(error.toString(), error: error));
    }
  }
}
