import 'package:authentication/cors/client/client_end_point.dart';
import 'package:authentication/cors/client/client_ihttp.dart';
import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/domain/model/auth_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  final ClientIHttp client;

  AuthService(this.client);

  Future<AuthModel> singUp({required AuthModel auth}) async {
    try {
      final response = await client.post(
        path: ClientEndPoint.singUp,
        body: auth.toJsonSingUp(),
      );
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    }
  }

  Future<AuthModel> login({required AuthModel auth}) async {
    try {
      final response = await client.post(
        path: ClientEndPoint.login,
        body: auth.toJsonSingUp(),
      );
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    }
  }

  Future<AuthModel> update({required AuthModel auth}) async {
    try {
      Map<String, dynamic> body = {"password": auth.password};
      Map<String, dynamic> headers = {
        "verification": auth.validationModel?.code.toString(),
        "uuid": auth.uuid.toString(),
      };
      final response = await client.put(
        path: ClientEndPoint.updateAccount,
        body: body,
        queryHeaders: headers,
      );
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    }
  }

  Future<AuthModel> delete({required AuthModel auth}) async {
    try {
      final response = await client.delete(
        path: '${ClientEndPoint.deleteAccount}/${auth.uuid}',
      );
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    }
  }
}
