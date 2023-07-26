// ignore_for_file: prefer_const_constructors, await_only_futures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // controllers
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmpassword = TextEditingController();

  // Future addDat() async {
  //   final docUs = FirebaseFirestore.instance.collection("users").doc();

  //   final jsjs = {
  //     'email': _email.text.trim(),
  //   };
  //   await docUs.set(jsjs);
  // }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

  Future signUp() async {
    // Authenticate user
    if (passwordConfirmed()) {
      if (_password.text.trim().length >= 8) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Passwords must be at least 8 characters"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
    }
  }

  bool passwordConfirmed() {
    return _password.text.trim() == _confirmpassword.text.trim() ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to neoArch store")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please sign up to continue",
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

              // confirm password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  obscureText: true,
                  controller: _confirmpassword,
                  decoration: InputDecoration(
                    label: Text("Confirm password"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              // sign up button

              FilledButton.icon(
                onPressed: signUp,
                label: Text("Sign up"),
                icon: Icon(Icons.person_add_outlined),
              ),

              // Log in

              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
