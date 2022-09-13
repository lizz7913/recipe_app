import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/src/screens/login_screen.dart';
import 'package:onboarding/src/screens/recipes_screen.dart';

// You should not show login/singup pages each time the app opens
// if the user is logged in, go directly to recipes page
// else => show login/signup

// you can check if the user is signed in by FirebaseAuth
// this page check for user state and choose
// which page to go to depends on user state
class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();

    // resolve next page only when this widget is built
    // else it will cause errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resolveNextPage();
    });
  }

  void _resolveNextPage() {
    var user = FirebaseAuth.instance.currentUser;

    // if user is null
    // it means he is not signed in => go to login/signup page
    // else => go to recipes page
    if (user == null) {
      _navigateIfNotLoggedIn();
    } else {
      _navigateIfLoggedIn();
    }
  }

  void _navigateIfLoggedIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => RecipesScreen(userName: "no name"),
      ),
    );
  }

  void _navigateIfNotLoggedIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading"),
      ),
    );
  }
}
