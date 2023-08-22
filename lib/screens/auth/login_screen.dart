import 'package:cyberwatch/utils/colors.dart';
import 'package:cyberwatch/widgets/button_widget.dart';
import 'package:cyberwatch/widgets/text_widget.dart';
import 'package:cyberwatch/widgets/textfield_widget.dart';
import 'package:cyberwatch/widgets/toast_widget.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
              opacity: 120,
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 250,
                        ),
                        TextBold(
                          text: 'SentiNex',
                          fontSize: 80,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextBold(
                            text: 'Login',
                            fontSize: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldWidget(
                              label: 'Username',
                              controller: usernameController),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWidget(
                              isObscure: true,
                              label: 'Password',
                              controller: passwordController),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonWidget(
                            radius: 10,
                            height: 60,
                            textColor: Colors.white,
                            color: Colors.black,
                            label: 'Login',
                            onPressed: () {
                              if (usernameController.text == 'username' &&
                                  passwordController.text == 'password') {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              } else {
                                showToast('INVALID ACCOUNT!');
                              }
                            },
                          ),
                        ],
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
  }
}
