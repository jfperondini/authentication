import 'package:authentication/cors/client/client_end_point.dart';
import 'package:authentication/cors/client/client_ihttp.dart';
import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/domain/model/auth_model.dart';
import 'package:dio/dio.dart';

class VerificationService {
  final ClientIHttp client;

  VerificationService(this.client);

  Future<AuthModel> verification({required int code}) async {
    try {
      Map<String, dynamic> body = {"code": code};
      final response = await client.post(path: ClientEndPoint.verification, body: body);
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    }
  }
}
