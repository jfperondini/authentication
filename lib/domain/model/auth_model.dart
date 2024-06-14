import 'package:authentication/domain/model/validation_model.dart';

class AuthModel {
  String? uuid;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? accessToken;
  int? expiresIn;
  String? message;
  ValidationModel? validationModel;

  AuthModel({
    this.uuid,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.accessToken,
    this.expiresIn,
    this.message,
    this.validationModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'accessToken': accessToken,
      'expiresIn': expiresIn,
      'message': message,
      'validationModel': validationModel?.toJson(),
    };
  }

  Map<String, dynamic> toJsonSingUp() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> map) {
    return AuthModel(
      uuid: map['uuid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      accessToken: map['accessToken'] ?? '',
      expiresIn: map['expiresIn'] ?? 0,
      message: map['message'] ?? '',
      validationModel: ValidationModel.fromJson(map['validationModel'] ?? {}),
    );
  }

  factory AuthModel.empty() {
    return AuthModel.fromJson({});
  }

  factory AuthModel.create() {
    return AuthModel();
  }
}