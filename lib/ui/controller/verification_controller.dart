import 'package:authentication/data/service/verificaiton_service.dart';
import 'package:authentication/domain/model/auth_model.dart';
import 'package:authentication/ui/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class VerificationController extends ChangeNotifier {
  final AuthController authController;
  final VerificationService verificationService;

  VerificationController(this.authController, this.verificationService);

  List<String> listCode = [];
  List<TextEditingController> listControllers = [];

  init() {
    setListCode();
    setListController();
    notifyListeners();
  }

  setListCode() {
    listCode = authController.authSelect?.validationModel?.code.toString().split('') ?? [];
    notifyListeners();
  }

  setListController() {
    listControllers.clear();
    for (int i = 0; i < listCode.length; i++) {
      listControllers.add(TextEditingController(text: listCode[i]));
    }
    notifyListeners();
  }

  validatedCode() async {
    AuthModel authModel = await verificationService.verification(
      code: authController.authSelect?.validationModel?.code ?? 0,
    );
    authController.authSelect?.uuid = authModel.uuid;
    notifyListeners();
  }

  clearVerification() {
    listCode.clear();
    listControllers.clear();
    notifyListeners();
  }
}
