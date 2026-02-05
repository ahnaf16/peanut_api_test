import 'package:peanut_api_test/main.export.dart';

typedef Report<T> = Either<Failure, T>;
typedef FutureReport<T> = Future<Report<T>>;

Future<T> failToErr<T>(Failure f) => f.toFuture<T>();

Either<Failure, R> failure<R>(String msg, {Object? e, StackTrace? s}) {
  return Left(Failure(msg, error: e, stackTrace: s ?? StackTrace.current));
}

class Failure {
  const Failure(this.msg, {this.error, this.stackTrace});
  const Failure.regular(this.msg, {this.error, this.stackTrace});

  final String msg;
  final Object? error;
  final StackTrace? stackTrace;

  @override
  String toString() => msg;

  Future<T> toFuture<T>() {
    final future = Future<T>.error(this, stackTrace);
    return future;
  }
}

extension DioExceptionTypeEx on DioExceptionType {
  bool get isTimeout =>
      this == DioExceptionType.connectionTimeout ||
      this == DioExceptionType.receiveTimeout ||
      this == DioExceptionType.connectionError ||
      this == DioExceptionType.sendTimeout;
}
