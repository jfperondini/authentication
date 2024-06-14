// ignore_for_file: use_build_context_synchronously

import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/cors/routes/routes.dart';
import 'package:authentication/cors/shared/styles/styles.dart';
import 'package:authentication/cors/shared/widgets/elevated_button_widget.dart';
import 'package:authentication/cors/shared/widgets/text_form_field_widget.dart';
import 'package:authentication/ui/controller/validation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ValidationPage extends StatelessWidget {
  const ValidationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    final validation = Modular.get<ValidationController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check your email',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Styles.deepPurpleAccent,
          ),
        ),
        leading: IconButton(
          onPressed: () async {
            await Modular.to.pushNamed(Routes.init);
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.width * 0.015),
                const Text(
                  'Type your email to confirm authenticity.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: size.width * 0.05),
                TextFormFieldWidget(
                  controller: validation.email,
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
                SizedBox(height: size.width * 0.05),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButtonWidget(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        try {
                          await validation.validatedEmail();
                          await validation.clearValidation();
                          await Modular.to.pushNamed(Routes.verification);
                        } on ServerException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message), backgroundColor: Styles.redAccent),
                          );
                        }
                      }
                    },
                    title: 'Verify Email',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
