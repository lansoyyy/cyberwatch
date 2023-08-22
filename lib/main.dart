import 'package:cyberwatch/screens/new_home_screen.dart';
import 'package:cyberwatch/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCUSrbTWEnhyMM3d5VRDnMQzOO95L_nG-8",
          appId: "1:177303697074:web:d45849f1c197fd0421bbab",
          messagingSenderId: "177303697074",
          projectId: "cyberwatch-dfd11",
          storageBucket: "cyberwatch-dfd11.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        color: primary, title: 'SentiNex', home: NewHomeScreen());
  }
}
