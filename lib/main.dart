import 'package:admin_web/main_screens/home_screen.dart';
import 'package:admin_web/main_screens/survey_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'authentication/authentication_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCBAPA_OzRTZ0SuI5yl-4gLPfnZT5nXb-g",
          appId: "1:677880256454:web:aed71903507168e7f944c7",
          messagingSenderId: "677880256454",
          projectId:"admin-web-96428"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen()
        // FirebaseAuth.instance.currentUser == null ? const LoginScreen() : HomeScreen()
      );
  }
}
