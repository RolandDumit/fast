import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  final String accessTokenKey;
  final String refreshTokenKey;
  final String idTokenKey;

  String? _accessToken;

  String? get accessToken => _accessToken;

  TokenManager({
    required this.accessTokenKey,
    required this.refreshTokenKey,
    required this.idTokenKey,
  });

  /// Clear the access token
  void clearAccessToken() {
    _accessToken = null;
    _secureStorage.delete(key: accessTokenKey);
  }

  /// Clear all tokens
  void clearAllTokens() {
    _accessToken = null;
    _secureStorage.deleteAll();
  }

  /// Write tokens to secure storage
  setTokens({
    required String? accessToken,
    required String? refreshToken,
    required String? idToken,
  }) {
    _accessToken = accessToken;

    _secureStorage.write(
      key: accessTokenKey,
      value: accessToken,
    );
    _secureStorage.write(
      key: refreshTokenKey,
      value: refreshToken,
    );
    _secureStorage.write(
      key: idTokenKey,
      value: idToken,
    );
  }

  /// Set only the access token
  void setAccessToken(String token) {
    _accessToken = token;
    _secureStorage.write(
      key: accessTokenKey,
      value: token,
    );
  }

  /// Set only the refresh token
  void setRefreshToken(String token) {
    _secureStorage.write(
      key: refreshTokenKey,
      value: token,
    );
  }

  /// Set only the id token
  void setIdToken(String token) {
    _secureStorage.write(
      key: idTokenKey,
      value: token,
    );
  }

  /// Read access token
  Future<String?> readAccessToken() async => await _secureStorage.read(key: accessTokenKey);

  /// Read refresh token
  Future<String?> readRefreshToken() async => await _secureStorage.read(key: refreshTokenKey);

  /// Read id token
  Future<String?> readIdToken() async => await _secureStorage.read(key: idTokenKey);
}
