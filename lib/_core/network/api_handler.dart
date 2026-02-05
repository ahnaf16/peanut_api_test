import 'dart:convert';
import 'dart:io';

import 'package:post_wagens/main.export.dart';

mixin ApiHandler {
  DioClient get client => locate<DioClient>();

  FutureReport<Base<T>> handleBase<T>({
    required Future<Response> Function() call,
    required T Function(Map<String, dynamic> map) mapper,
  }) async {
    try {
      return handle(
        call: call,
        mapper: (data) {
          final model = Base.fromMap(data, (v) => mapper(v));
          return model;
        },
      );
    } catch (e, s) {
      catErr('ApiHandler', e, s);
      return failure('Unexpected error.', e: e, s: s);
    }
  }

  FutureReport<T> handle<T>({
    required Future<Response> Function() call,
    required T Function(Map<String, dynamic> map) mapper,
  }) async {
    try {
      return handleRaw(
        call: call,
        mapper: (data) {
          Map<String, dynamic> decoded = {};

          if (data case final Map<String, dynamic> decode) decoded = decode;
          if (data case final String decode when !decode.startsWith('<!doctype html>')) {
            final parsed = jsonDecode(decode);
            if (parsed is Map<String, dynamic>) {
              decoded = parsed;
            } else {
              decoded = {'data': parsed};
            }
          }

          return mapper(decoded);
        },
      );
    } catch (e, s) {
      catErr('ApiHandler', e, s);
      return failure('Unexpected error.', e: e, s: s);
    }
  }

  FutureReport<T> handleRaw<T>({
    required Future<Response> Function() call,
    required T Function(dynamic map) mapper,
  }) async {
    try {
      final Response(:statusCode, :data) = await call();

      return right(mapper(data));
    } on SocketException catch (e, st) {
      return failure(e.message, e: e, s: st);
    } on DioException catch (e) {
      return left(e.toFailure());
    } on Failure catch (e) {
      return left(e);
    } catch (e, s) {
      catErr('ApiHandler', e, s);
      return failure('Unexpected error.', e: e, s: s);
    }
  }
}

extension DioErrorX on DioException {
  Failure toFailure() {
    // No internet or connection issues
    try {
      if (type == DioExceptionType.connectionError ||
          type == DioExceptionType.connectionTimeout ||
          type == DioExceptionType.unknown) {
        return const Failure('No internet connection.');
      }

      // Timeout
      if (type == DioExceptionType.receiveTimeout || type == DioExceptionType.sendTimeout) {
        return const Failure('Connection timed out.');
      }

      final status = response?.statusCode ?? 0;

      var res = response?.data;

      if (res case final String s when !s.startsWith('<!DOCTYPE html>')) res = jsonDecode(s);

      final serverMessage = switch (res) {
        // Server error message ignoring ZOD
        {'message': final String msg} when msg != 'Zod Validation Error' => msg,
        // ZOD validation error message
        {'errorSources': final List list} when list.isNotEmpty =>
          list.firstOrNull is Map ? list.first['message'] : null,
        _ => null,
      };

      if (serverMessage != null && serverMessage.isNotEmpty) {
        return Failure(serverMessage, error: this, stackTrace: stackTrace);
      }

      return Failure('Something went wrong. (code $status)', error: this, stackTrace: stackTrace);
    } catch (e, s) {
      return Failure('Something went wrong.', error: e, stackTrace: s);
    }
  }
}
