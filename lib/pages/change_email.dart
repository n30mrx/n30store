// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  String? anErr;
  final newEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change email address"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: newEmail,
                decoration: InputDecoration(
                  hintText: "something@example.com",
                  labelText: "New email",
                  border: OutlineInputBorder(),
                  errorText: anErr,
                  suffixIcon: Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    showDuration: Duration(seconds: 3),
                    message:
                        "We will send you an email \nwith a link to verify \nyour ownership of \nthe provided account",
                    child: Icon(Icons.info_outline),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FilledButton.icon(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.currentUser!
                        .verifyBeforeUpdateEmail(newEmail.text.trim())
                        .then(
                      (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Email sent!"),
                          ),
                        );
                      },
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$e"),
                      ),
                    );
                  }
                },
                label: Text("Send verfication email"),
                icon: Icon(Icons.send),
              )
            ],
          ),
        ),
      ),
    );
  }
}
