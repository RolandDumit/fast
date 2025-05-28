import 'package:dio/dio.dart';

extension ResponseStatusCodesExtensions on Response {
  bool get isSuccessful => statusCode != null ? statusCode! >= 200 && statusCode! < 300 : false;

  bool get isUnauthorized => statusCode != null ? statusCode! == 401 : false;

  bool get isForbidden => statusCode != null ? statusCode! == 403 : false;

  bool get isNotFound => statusCode != null ? statusCode! == 404 : false;

  bool get isBadRequest => statusCode != null ? statusCode! == 400 : false;

  bool get isServerError => statusCode != null ? statusCode! >= 500 : false;

  bool get isClientError => statusCode != null ? statusCode! >= 400 && statusCode! < 500 : false;
}
