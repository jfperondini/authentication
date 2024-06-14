import 'package:authentication/data/service/validation_service.dart';
import 'package:flutter/material.dart';

import 'package:authentication/ui/controller/auth_controller.dart';

class ValidationController extends ChangeNotifier {
  final AuthController authController;
  final ValidationService validationService;

  ValidationController(this.authController, this.validationService);

  final email = TextEditingController();

  validatedEmail() async {
    authController.authSelect?.validationModel = await validationService.validation(email: email.text);
    authController.authSelect?.email = email.text;
    notifyListeners();
  }

  clearValidation() {
    email.text = '';
    notifyListeners();
  }
}
