// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n30store/utils/password_reset.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const LoginPage({super.key, required this.showSignUpPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _emailReset = TextEditingController();

  // Sign in method
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "An error has occured",
            ),
            content: Text("$e"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Okay"),
              )
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _emailReset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome back to neoArch store")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please sign in to continue",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),

              // email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: "something@example.com",
                    label: Text("email"),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              SizedBox(
                height: 10,
              ),

              // password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  obscureText: true,
                  controller: _password,
                  decoration: InputDecoration(
                    label: Text("password"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onTap: () => resetPass(_emailReset, context),
                    ),
                  )
                ],
              ),
              // sign in button

              FilledButton.icon(
                onPressed: signIn,
                label: Text("Sign in"),
                icon: Icon(Icons.login_outlined),
              ),

              SizedBox(
                height: 10,
              ),

              // no account?

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account yet? "),
                  GestureDetector(
                    onTap: widget.showSignUpPage,
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "OR",
                style: TextStyle(fontSize: 20),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    // await FirebaseAuth.instance.signInWithEmailAndPassword(
                    //     email: "anonacc@n30arch.arch",
                    //     password: "anonaccArchAc5855#X");
                    await FirebaseAuth.instance.signInAnonymously();
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "An error has occured",
                          ),
                          content: Text("$e"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Okay"),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "Continue withou an account",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
