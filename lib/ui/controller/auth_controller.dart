import 'package:authentication/cors/server/server_data.dart';
import 'package:authentication/data/service/auth_service.dart';
import 'package:authentication/domain/model/auth_model.dart';
import 'package:flutter/cupertino.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService;
  final ServerData serverData;

  AuthController(this.authService, this.serverData);

  AuthModel? authSelect;

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool passwoardVisibility = true;
  bool isLogin = true;

  validatedLogin() async {
    AuthModel newAuth = AuthModel(email: email.text, password: password.text);
    authSelect = await authService.login(auth: newAuth);
    serverData.setToken(token: authSelect?.accessToken ?? '');
    notifyListeners();
  }

  forgotPassword() {
    AuthModel authModel = AuthModel.create();
    authSelect = authModel;
    notifyListeners();
  }

  singUp({required String firstName, required String lastName}) async {
    AuthModel newAuth = AuthModel(email: email.text, password: password.text, firstName: firstName, lastName: lastName);
    authSelect = await authService.singUp(auth: newAuth);
    notifyListeners();
  }

  update() async {
    authSelect?.password = password.text;
    authSelect = await authService.update(auth: authSelect ?? AuthModel.empty());
    notifyListeners();
  }

  switchVisibility() {
    passwoardVisibility = !passwoardVisibility;
    notifyListeners();
  }

  toggleFormVisibility() {
    isLogin = !isLogin;
    notifyListeners();
  }

  clearAuth() {
    email.text = '';
    password.text = '';
    confirmPassword.text = '';
    notifyListeners();
  }
}
