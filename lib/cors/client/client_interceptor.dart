// ignore_for_file: avoid_print

import 'package:authentication/cors/server/server_data.dart';
import 'package:dio/dio.dart';

class ClientInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final serverData = ServerData.instance;
    String? token = await serverData.getToken();
    if (token.isNotEmpty) {
      final String headerAuth = 'Bearer $token';
      options.headers['Authorization'] = headerAuth;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      print('Response status: ${err.response!.statusCode}');
      print('Response data: ${err.response!.data}');
    }

    handler.next(err);
  }
}
