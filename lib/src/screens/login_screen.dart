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
              textAlign: TextAlign.center,
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
    // validate fields before trying to login
    // validate function returns error string
    // if its not null => there is error => display it to user
    // else => no errors and continue singin
    String validationErrorMessage = _validateFields();
    if(validationErrorMessage != null){
      setState(() {
        errorMessage = validationErrorMessage;
      });
      return;
    }else{
      // clear prevoius error message
      setState(() {
        errorMessage = "";
      });

    }

    try {
      String username = userNameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RecipesScreen(userName: userNameController.text,)));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  String _validateFields(){
    // validate all fields has value
    String username = userNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if(username.isEmpty || email.isEmpty || password.isEmpty ){
      return "Please Fill all fields";
    }

    // validate email is valid
    // email validation can be complicated
    // but here we will just check if email has '@' in it
    // it it has '@' we will assume it is valid email
    // else => its not valid
    if(! email.contains("@")){
      return "Invalid Email Address";
    }

    // we can also validate password
    // for example we can say it has to be at least
    // 8 characters long
    // but I will leave it to you 🌚🌚

    // we can also split validation to many functions
    // to be more readable and clean
    // for example _validateEmail and _validatePassword
    // I will also leave that to you 🌚🌚

    // return null => means there is no validation errors
    return null;
  }


}

