// ignore_for_file: avoid_print
import 'package:authentication/cors/client/client_end_point.dart';
import 'package:authentication/cors/client/client_ihttp.dart';
import 'package:authentication/cors/client/client_interceptor.dart';
import 'package:dio/dio.dart';

class ClientHttp implements ClientIHttp {
  final List<InterceptorsWrapper>? interceptor;

  late final Dio dio;
  ClientHttp({this.interceptor}) {
    dio = Dio(BaseOptions(baseUrl: ClientEndPoint.baseUrl));
    if (interceptor != null) {
      dio.interceptors.addAll(interceptor ?? []);
    }
  }

  factory ClientHttp.start() {
    return ClientHttp(interceptor: [ClientInterceptors()]);
  }

  @override
  Future post({required String path, required Map body}) async {
    final response = await dio.post(
      path,
      data: body,
      options: Options(headers: {ClientEndPoint.contetType: ClientEndPoint.applicationJson}),
    );
    return response;
  }

  @override
  Future put({required String path, required Map body, required Map<String, dynamic>? queryHeaders}) async {
    final response = await dio.put(
      path,
      data: body,
      options: Options(
        headers: {
          ClientEndPoint.contetType: ClientEndPoint.applicationJson,
          ...?queryHeaders,
        },
      ),
    );
    return response;
  }

  @override
  Future patch({required String path, required Map body, required Map<String, dynamic>? queryParameters}) async {
    final response = await dio.put(
      path,
      data: body,
      options: Options(headers: {ClientEndPoint.contetType: ClientEndPoint.applicationJson}),
      queryParameters: queryParameters,
    );
    return response;
  }

  @override
  Future delete({required String path}) async {
    final response = await dio.delete(
      path,
      options: Options(headers: {ClientEndPoint.contetType: ClientEndPoint.applicationJson}),
    );
    return response;
  }
}
