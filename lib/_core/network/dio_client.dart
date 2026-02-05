import 'package:peanut_api_test/main.export.dart';

export 'package:dio/dio.dart';

class DioClient {
  DioClient({this.useEvent = true}) {
    _dio = Dio(_options);
    _dio.interceptors.add(_interceptorsWrapper());
    _dio.interceptors.add(DioLogger());
  }

  final bool useEvent;
  late Dio _dio;

  final _options = BaseOptions(
    baseUrl: Endpoints.clientApi,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {'Accept': 'application/json'},
  );

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _dio.get(
      url,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // patch:----------------------------------------------------------------------
  Future<Response> patch(
    String url, {
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    String? baseUrl,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(url, data: data, options: options, cancelToken: cancelToken);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Interceptors :----------------------------------------------------------------------
  InterceptorsWrapper _interceptorsWrapper() => InterceptorsWrapper(
    onRequest: (options, handler) async {
      return handler.next(options);
    },
    onResponse: (res, handler) async {
      return handler.next(res);
    },
    onError: (err, handler) async {
      if (err.response?.data == 'Access denied') {
        EvBus.instance.fireLogoutEv();
        return handler.next(err);
      }
      return handler.next(err);
    },
  );
}
