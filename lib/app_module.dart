import 'package:authentication/cors/client/client_http.dart';
import 'package:authentication/cors/client/client_ihttp.dart';
import 'package:authentication/cors/routes/routes.dart';
import 'package:authentication/cors/server/server_data.dart';
import 'package:authentication/data/service/auth_service.dart';
import 'package:authentication/data/service/user_service.dart';
import 'package:authentication/data/service/validation_service.dart';
import 'package:authentication/data/service/verificaiton_service.dart';
import 'package:authentication/ui/controller/auth_controller.dart';
import 'package:authentication/ui/controller/user_controller.dart';
import 'package:authentication/ui/controller/validation_controller.dart';
import 'package:authentication/ui/controller/verification_controller.dart';
import 'package:authentication/ui/view/forgot_password_page.dart';
import 'package:authentication/ui/view/home_page.dart';
import 'package:authentication/ui/view/login_page.dart';
import 'package:authentication/ui/view/sing_up_page.dart';
import 'package:authentication/ui/view/validation_page.dart';
import 'package:authentication/ui/view/verification_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ClientIHttp>(ClientHttp.start);
    i.addInstance(ServerData.instance);

    i.addLazySingleton(AuthService.new);
    i.addLazySingleton(ValidationService.new);
    i.addLazySingleton(VerificationService.new);
    i.addLazySingleton(UserService.new);
    
    i.addLazySingleton(AuthController.new);
    i.addLazySingleton(ValidationController.new);
    i.addLazySingleton(VerificationController.new);
    i.addLazySingleton(UserController.new);
  }

  @override
  void routes(r) {
    r.child(Routes.init, child: (_) => const LoginPage());
    r.child(Routes.singUp, child: (_) => const SingUpPage());
    r.child(Routes.validation, child: (_) => const ValidationPage());
    r.child(Routes.verification, child: (_) => const VerificationPage());
    r.child(Routes.forgotPassword, child: (_) => const ForgotPasswordPage());
    r.child(Routes.home, child: (_) => const HomePage());
  }
}
