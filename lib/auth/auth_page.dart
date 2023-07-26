import 'package:flutter/material.dart';
import 'package:n30store/auth/signup_page.dart';
import 'package:n30store/auth/login.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initially show the login page
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showSignUpPage: toggleScreens,
      );
    } else {
      return SignupPage(showLoginPage: toggleScreens);
    }
  }
}
