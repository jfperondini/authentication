// ignore_for_file: use_build_context_synchronously
import 'package:authentication/cors/error/expection/server_exception.dart';
import 'package:authentication/cors/routes/routes.dart';
import 'package:authentication/cors/shared/styles/styles.dart';
import 'package:authentication/cors/shared/widgets/elevated_button_widget.dart';
import 'package:authentication/cors/shared/widgets/text_form_field_widget.dart';
import 'package:authentication/ui/controller/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    final verification = Modular.get<VerificationController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pin Code',
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
      body: FutureBuilder(
        future: verification.init(),
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
                      'Check authenticity confirmation...',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: size.width * 0.07),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.width * 0.12,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: verification.listControllers.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 50.0,
                                height: 50.0,
                                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Center(
                                  child: TextFormFieldWidget(
                                    autofocus: false,
                                    controller: verification.listControllers[index],
                                    maxLength: 1,
                                    textAlign: TextAlign.center,
                                    onChanged: (String value) {
                                      if (value.isNotEmpty && index < verification.listCode.length) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.width * 0.07),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButtonWidget(
                        onPressed: () async {
                          {
                            try {
                              await verification.validatedCode();
                              await verification.clearVerification();
                              await Modular.to.pushNamed(Routes.forgotPassword);
                            } on ServerException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message), backgroundColor: Styles.redAccent),
                              );
                            }
                          }
                        },
                        title: 'Verify Code',
                      ),
                    ),
                    SizedBox(height: size.width * 0.02),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
