import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onboarding/src/screens/recipes_screen.dart';

import 'signup_screen.dart';

class LoginWidget extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
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
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen(userName: userNameController.text,)));
              } on FirebaseAuthException catch (e) {
                print(e);
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
            },
            child: Text(
              'LOGIN',
              style: TextStyle(
                color: Colors.white,
              ),
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
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}

class LoginScreen extends StatelessWidget {
  final String userName;

  const LoginScreen({Key key,@required this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe'),
      ),
      body: RecipesScreen(userName: this.userName,),
    );
  }
}