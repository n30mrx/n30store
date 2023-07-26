// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void resetPass(TextEditingController _emailReset, BuildContext context) {
  _emailReset.text = "";
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Reset your password"),
        content: const Text(
          "Enter your email to send password reset link",
        ),
        actions: [
          TextField(
            controller: _emailReset,
            decoration: const InputDecoration(
                hintText: "something@example.com", label: Text("Email")),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailReset.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Password reset email sent!",
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("$e")));
                    }
                  },
                  child: const Text("Send email"),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          )
        ],
      );
    },
  );
}
