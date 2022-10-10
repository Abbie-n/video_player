import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';

class DioInterceptor extends Interceptor with NetworkLoggy {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    loggy.info('${options.method} - ${options.uri}');
    loggy
        .info('${options.method} - ${options.data ?? options.queryParameters}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    loggy.debug('${response.statusCode} - ${response.statusMessage}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    loggy.error('${err.response!.statusCode} - ${err.response}');
    return super.onError(err, handler);
  }
}
