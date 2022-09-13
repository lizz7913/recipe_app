import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/src/screens/landing_screen.dart';
import 'package:onboarding/src/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: LandingScreen(),
    );
  }


}

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>Scaffold(
    body: LoginScreen(),
  );
}

