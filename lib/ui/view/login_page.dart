// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/cors/routes/routes.dart';
import 'package:authentication/cors/shared/styles/styles.dart';
import 'package:authentication/cors/shared/widgets/elevated_button_widget.dart';
import 'package:authentication/cors/shared/widgets/text_form_field_widget.dart';
import 'package:authentication/ui/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    final auth = Modular.get<AuthController>();
    return Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: auth,
          builder: (context, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.width * 0.05),
                      SizedBox(
                          height: size.width * 0.3,
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.cover,
                          )),
                      SizedBox(height: size.width * 0.05),
                      const Text(
                        'Fill in the fields below with your access data.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      TextFormFieldWidget(
                        controller: auth.email,
                        hintText: 'Email Adress',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          final exp = RegExp(r"^([\w\-_]+)(@+)([\w]+)((\.+\w{2,3}){1,2})$");
                          if (exp.hasMatch(value ?? '') == false) {
                            return 'please provide a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.width * 0.03),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await auth.forgotPassword();
                              await Modular.to.pushNamed(Routes.validation);
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.05),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButtonWidget(
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              try {
                                await auth.validatedLogin();
                                await auth.clearAuth();
                                await Modular.to.pushNamedAndRemoveUntil(Routes.home, ModalRoute.withName(Routes.home));
                              } on ServerException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message), backgroundColor: Styles.redAccent),
                                );
                              }
                            }
                          },
                          title: 'Log In',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await auth.clearAuth();
                              await Modular.to.pushNamed(Routes.singUp);
                            },
                            child: Text(
                              'Sing-Up ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Styles.deepPurpleAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
