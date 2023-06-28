import 'package:cyberwatch/screens/auth/login_screen.dart';
import 'package:cyberwatch/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: primary, title: 'Cyberwatch', home: LoginScreen());
  }
}
