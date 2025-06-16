import 'package:dio/dio.dart';

class NetworkService {
  String? cookie;

  static Dio instance() {
    final dio = Dio(
      BaseOptions(
        followRedirects: false,
      ),
    );
    dio.options.headers['Content-Type'] = 'application/json';
    dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}


class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.next(options);
  }

  @override
  void onError(err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}
