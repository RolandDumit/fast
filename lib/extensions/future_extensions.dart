import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../utils/failures.dart' as failures;

extension FutureToResultExtension on Future {
  Future<Result<Success, Failure>> toResult<Success, Failure>() => then(
        (value) => Result.success(value),
        onError: (error, stackTrace) => switch (error) {
          final DioException dioException =>
            Result.error(failures.DioExceptionFailure(dioException.message, dioException: dioException)),
          _ => Result.error(failures.GenericRequestFailure(error.toString())),
        },
      );
}
