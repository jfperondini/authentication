// ignore_for_file: use_build_context_synchronously
import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/cors/routes/routes.dart';
import 'package:authentication/cors/shared/styles/styles.dart';
import 'package:authentication/cors/shared/widgets/elevated_button_widget.dart';
import 'package:authentication/cors/shared/widgets/text_form_field_widget.dart';
import 'package:authentication/ui/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    final auth = Modular.get<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Styles.deepPurpleAccent,
          ),
        ),
        leading: IconButton(
          onPressed: () async {
            await Modular.to.pushNamed(Routes.validation);
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
      ),
      body: ListenableBuilder(
          listenable: auth,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.width * 0.015),
                      const Text(
                        'Don\'t worry, you just need to enter the details below to recover your password.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      TextFormFieldWidget(
                        controller: auth.password,
                        hintText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: auth.passwoardVisibility,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await auth.switchVisibility();
                          },
                          icon: Icon(
                            auth.passwoardVisibility ? Icons.visibility : Icons.visibility_off,
                            color: Styles.deepPurpleAccent,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'password field cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.width * 0.03),
                      TextFormFieldWidget(
                        controller: auth.confirmPassword,
                        hintText: 'Confirm Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: auth.passwoardVisibility,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await auth.switchVisibility();
                          },
                          icon: Icon(
                            auth.passwoardVisibility ? Icons.visibility : Icons.visibility_off,
                            color: Styles.deepPurpleAccent,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'password field cannot be empty';
                          }
                          if (value != auth.password.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.width * 0.05),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButtonWidget(
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              try {
                                await auth.update();
                                await auth.clearAuth();
                                await Modular.to.popAndPushNamed(Routes.init);
                              } on ServerException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message), backgroundColor: Styles.redAccent),
                                );
                              }
                            }
                          },
                          title: 'Reset Password',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
