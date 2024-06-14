// ignore_for_file: use_build_context_synchronously
import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/cors/routes/routes.dart';
import 'package:authentication/cors/shared/styles/styles.dart';
import 'package:authentication/cors/shared/widgets/elevated_button_widget.dart';
import 'package:authentication/cors/shared/widgets/text_form_field_widget.dart';
import 'package:authentication/ui/controller/auth_controller.dart';
import 'package:authentication/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    final auth = Modular.get<AuthController>();
    final user = Modular.get<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sing-Up',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Styles.deepPurpleAccent,
          ),
        ),
        leading: IconButton(
          onPressed: () async {
            await auth.clearAuth();
            Modular.to.pop();
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
                        'Don\'t worry, you just need to enter the details below to create your profile.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      TextFormFieldWidget(
                        controller: user.firstName,
                        hintText: 'First Name',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'first name field cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.width * 0.03),
                      TextFormFieldWidget(
                        controller: user.lastName,
                        hintText: 'Last Name',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'last name field cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.width * 0.03),
                      TextFormFieldWidget(
                        controller: auth.email,
                        textInputAction: TextInputAction.next,
                        hintText: 'Email Adress',
                        keyboardType: TextInputType.emailAddress,
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
                                await auth.singUp(firstName: user.firstName.text, lastName: user.lastName.text);
                                //await user.register();
                                await auth.clearAuth();
                                await user.clearUser();
                                await Modular.to.popAndPushNamed(Routes.init);
                              } on ServerException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message), backgroundColor: Styles.redAccent),
                                );
                              }
                            }
                          },
                          title: 'Register',
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
