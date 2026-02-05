import 'dart:convert';
import 'dart:io';

import 'package:peanut_api_test/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin ApiHandler {
  DioClient get client => locate<DioClient>();

  QMap? getAuthData() {
    final sp = locate<SP>();
    final code = sp.loginCode.value;
    final token = sp.token.value;

    if (code == null || token == null) {
      EvBus.instance.fireLogoutEv();
      return null;
    }

    return {'login': code, 'token': token};
  }

  FutureReport<T> handle<T>({
    required Future<Response> Function() call,
    required FutureOr<T> Function(Map<String, dynamic> map) mapper,
  }) async {
    try {
      return handleRaw(
        call: call,
        mapper: (data) {
          Map<String, dynamic> decoded = {};

          if (data case final Map<String, dynamic> decode) decoded = decode;
          if (data case final String decode when !decode.low.startsWith('<!doctype html>')) {
            final parsed = jsonDecode(decode);
            if (parsed is Map<String, dynamic>) decoded = parsed;
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
    required FutureOr<T> Function(dynamic map) mapper,
  }) async {
    try {
      final Response(:statusCode, :data) = await call();

      return right(await mapper(data));
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
      if (type == .connectionError || type == .connectionTimeout || type == .unknown) {
        return const Failure('No internet connection.');
      }

      // Timeout
      if (type == .receiveTimeout || type == .sendTimeout) return const Failure('Connection timed out.');

      final status = response?.statusCode ?? 0;

      var res = response?.data;

      if (res case final String s when !s.low.startsWith('<!doctype html>')) res = jsonDecode(s);
      cat(res, 'DIO_ERROR');

      return Failure('Something went wrong. (code $status)', error: this, stackTrace: stackTrace);
    } catch (e, s) {
      return Failure('Something went wrong.', error: e, stackTrace: s);
    }
  }
}
