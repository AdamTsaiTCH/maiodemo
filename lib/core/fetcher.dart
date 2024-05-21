import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiBaseUriProvider =
    Provider<String>((_) => 'https://jsonplaceholder.typicode.com');

final apiFetchProvider = Provider<Dio>((ref) {
  final baseUri = ref.read(apiBaseUriProvider);

  final dio = Dio(BaseOptions(
    baseUrl: baseUri,
    connectTimeout: 30000,
    sendTimeout: 5000,
    receiveTimeout: 30000,
    contentType: 'application/json',
    // validateStatus: (status) => status == 200,
  ));

  dio.interceptors.addAll([
    LogInterceptor(
      request: false,
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: false,
    ),
    ResponseInterceptor(),
    ErrorInterceptor(),
  ]);

  return dio;
});

class ResponseInterceptor extends Interceptor {
  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}
