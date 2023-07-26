// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addapp extends StatelessWidget {
  Addapp({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController thumbnail = TextEditingController();
  final TextEditingController url = TextEditingController();
  final app = FirebaseFirestore.instance.collection('apps').doc();

  void postapp(
      BuildContext context, DocumentReference<Map<String, dynamic>> apps) {
    if (name.text.isEmpty | thumbnail.text.isEmpty | url.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill out all parameters")));
      return;
    } else {
      try {
        apps.set({
          'name': name.text.trim(),
          'img': thumbnail.text.trim(),
          'url': url.text.trim(),
          'time': Timestamp.now(),
          'id': apps.id
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Done!"),
            ),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New app post"),
      ),
      body: Center(
        child: Column(
          children: [
            // app name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "app name",
                  label: Text("app name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // app thumbnail
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: thumbnail,
                decoration: InputDecoration(
                  hintText: "app thumbnail",
                  label: Text("app thumbnail"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // app url
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: url,
                decoration: InputDecoration(
                  hintText: "app url",
                  label: Text("app url"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Submit button
            FilledButton(
              onPressed: () => postapp(context, app),
              child: Text("Post"),
            )
          ],
        ),
      ),
    );
  }
}
