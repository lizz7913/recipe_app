import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/src/screens/recipes_screen.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(
                    Icons.account_box,
                  ),
                  border: OutlineInputBorder()),
              controller: userNameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder()),
              controller: emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  border: OutlineInputBorder()),
              controller: passwordController,
            ),
          ),
          Container(
            color: Colors.blue,
            child: MaterialButton(
              onPressed: _signUp,
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void _signUp() async {
    // you also have to validate fields
    // and display error messages like in LoginPage
    // I will leave that to you 🌚🌚🌚


    // create user is async function, you have to wait for it to complete
    // and to put it in try catch
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      addUser();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipesScreen(
                    userName: userNameController.text,
                  )));
    } catch (e) {}
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users.add({
      'name': userNameController.text,
    });
  }
}
