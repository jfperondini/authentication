// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:authentication/cors/client/client_http.dart';
import 'package:authentication/data/service/auth_service.dart';
import 'package:authentication/data/service/validation_service.dart';
import 'package:authentication/data/service/verificaiton_service.dart';
import 'package:authentication/domain/model/auth_model.dart';
import 'package:authentication/domain/model/validation_model.dart';

final clientHttp = ClientHttp();
final serviceAuth = AuthService(clientHttp);
final serviceValidation = ValidationService(clientHttp);
final serviceVerification = VerificationService(clientHttp);

void main() {
  test('singUp', () async {
    AuthModel newAuthModel = AuthModel(email: "jf@email.com", password: "email");
    final result = await serviceAuth.singUp(auth: newAuthModel);
    expect(result, isNotNull);
    final formattedJson = jsonEncode(result);
    print(formattedJson);
  });

  test('login', () async {
    AuthModel newAuthModel = AuthModel(email: "jf@email.com", password: "new-teste");
    final result = await serviceAuth.login(auth: newAuthModel);
    expect(result, isNotNull);
    final formattedJson = jsonEncode(result);
    print(formattedJson);
  });

  test('validation verification update', () async {
    String email = "jf@email.com";
    String password = "new-teste";
    ValidationModel validation = await serviceValidation.validation(email: email);
    AuthModel authModel = await serviceVerification.verification(code: validation.code);

    authModel.email = email;
    authModel.password = password;
    authModel.validationModel = validation;

    final result = await serviceAuth.update(auth: authModel);
    expect(result, isNotNull);
    final formattedJson = json.encode(result);
    print('auth $formattedJson');
  });

  test('delete', () async {
    AuthModel newAuthModel = AuthModel(email: "jf@email.com", password: "new-teste");
    final login = await serviceAuth.login(auth: newAuthModel);

    final Map<String, Object> values = <String, Object>{'_tokenKey': login.accessToken ?? ''};
    SharedPreferences.setMockInitialValues(values);

    AuthModel authModel = AuthModel(uuid: 'c5b383e0-1684-452d-89d4-3a50fe8b8bf4');
    final result = await serviceAuth.delete(auth: authModel);
    expect(result, isNotNull);
    final formattedJson = json.encode(result);
    print('auth $formattedJson');
  });
}
