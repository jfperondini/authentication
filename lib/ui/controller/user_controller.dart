// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:authentication/domain/model/user_model.dart';
import 'package:authentication/ui/controller/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:authentication/cors/server/server_data.dart';
import 'package:authentication/data/service/user_service.dart';

class UserController extends ChangeNotifier {
  final AuthController authController;
  final UserService userService;
  final ServerData serverData;

  UserController(this.authController, this.userService, this.serverData);

  UserModel? userSelect;

  String get uuid => authController.authSelect?.uuid ?? '';

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  shared() async {
    userSelect = await userService.shared(uuid: uuid);
    notifyListeners();
  }

  update() async {
    UserModel updateUser = UserModel(
      firstName: firstName.text.isEmpty ? userSelect?.firstName : firstName.text,
      lastName: lastName.text.isEmpty ? userSelect?.lastName : lastName.text,
    );
    userSelect = await userService.update(user: updateUser, uuid: uuid);
    notifyListeners();
  }

  clearUser() {
    firstName.text = '';
    lastName.text = '';
    notifyListeners();
  }
}
