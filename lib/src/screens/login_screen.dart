import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onboarding/src/screens/recipes_screen.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final userNameController = TextEditingController();

  String errorMessage = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Login'),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'User name',
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
              onPressed: _performSingIn,
              child: Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          Row(
            children: [
              Text('Dont have an account?'),
              TextButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              }, child: Text('Sign up'))
            ],
          )
        ],
      ),
    );
  }

  Future _performSingIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RecipesScreen(userName: userNameController.text,)));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }

  }
}

