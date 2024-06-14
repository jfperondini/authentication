import 'package:authentication/cors/client/client_end_point.dart';
import 'package:authentication/cors/client/client_ihttp.dart';
import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/domain/model/validation_model.dart';
import 'package:dio/dio.dart';

class ValidationService {
  final ClientIHttp client;

  ValidationService(this.client);

  Future<ValidationModel> validation({required String email}) async {
    try {
      Map<String, dynamic> body = {"email": email};
      final response = await client.post(path: ClientEndPoint.validation, body: body);
      return ValidationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    }
  }
}
