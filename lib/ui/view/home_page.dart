import 'package:authentication/cors/routes/routes.dart';
import 'package:authentication/cors/shared/styles/styles.dart';
import 'package:authentication/cors/shared/widgets/elevated_button_widget.dart';
import 'package:authentication/ui/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Modular.get<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Styles.deepPurpleAccent,
          ),
        ),
      ),
      body: FutureBuilder(
          future: user.shared(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.width * 0.03),
                    Text(
                      'Congratulations ${user.userSelect?.firstName} ${user.userSelect?.lastName}, you have registered ${user.userSelect?.email} and your email has been successfully authenticated.',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: size.width * 0.1),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButtonWidget(
                        onPressed: () async {
                          await Modular.to.pushNamedAndRemoveUntil(Routes.init, ModalRoute.withName(Routes.init));
                        },
                        title: 'Log Out',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
