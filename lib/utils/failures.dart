import 'package:dio/dio.dart';

sealed class Failure {
  final String? message;

  const Failure(this.message);
}

  /// REQUEST FAILURES -----------------------------------------------------------
class RequestFailure extends Failure {
  const RequestFailure(super.message);
}

class GenericRequestFailure extends RequestFailure {
  final Object? error;

  const GenericRequestFailure(super.message, {this.error});
}

class DioExceptionFailure extends RequestFailure {
  final DioException? dioException;

  const DioExceptionFailure(super.message, {this.dioException});
}

class RequestNotSuccessfulFailure extends RequestFailure {
  final Response? response;

  const RequestNotSuccessfulFailure(super.message, {this.response});
}
