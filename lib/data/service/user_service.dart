import 'package:authentication/cors/client/client_end_point.dart';
import 'package:authentication/cors/client/client_ihttp.dart';
import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/domain/model/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  final ClientIHttp client;

  UserService(this.client);

  // Future<UserModel> register({required UserModel user}) async {
  //   try {
  //     final response = await client.post(
  //       path: ClientEndPoint.registerUser,
  //       body: user.toJson(),
  //     );
  //     return UserModel.fromJson(response.data);
  //   } on DioException catch (e) {
  //     throw ServerException(message: e.response?.data);
  //   }
  // }

  Future<UserModel> shared({required String uuid}) async {
    try {
      Map<String, dynamic> body = {"uuid": uuid};
      final response = await client.post(
        path: ClientEndPoint.sharedUser,
        body: body,
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    }
  }

  Future<UserModel> update({required UserModel user, required String uuid}) async {
    try {
      final response = await client.post(
        path: '${ClientEndPoint.updateUser}/$uuid',
        body: user.toJson(),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    }
  }
}
