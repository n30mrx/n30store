// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addtool extends StatelessWidget {
  Addtool({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController thumbnail = TextEditingController();
  final TextEditingController url = TextEditingController();
  final tool = FirebaseFirestore.instance.collection('tools').doc();

  void posttool(
      BuildContext context, DocumentReference<Map<String, dynamic>> tools) {
    if (name.text.isEmpty | thumbnail.text.isEmpty | url.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill out all parameters")));
      return;
    } else {
      try {
        tools.set({
          'name': name.text.trim(),
          'img': thumbnail.text.trim(),
          'url': url.text.trim(),
          'time': Timestamp.now(),
          'id': tools.id
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
        title: Text("New tool post"),
      ),
      body: Center(
        child: Column(
          children: [
            // tool name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "tool name",
                  label: Text("tool name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // tool thumbnail
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: thumbnail,
                decoration: InputDecoration(
                  hintText: "tool thumbnail",
                  label: Text("tool thumbnail"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // tool url
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: url,
                decoration: InputDecoration(
                  hintText: "tool url",
                  label: Text("tool url"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Submit button
            FilledButton(
              onPressed: () => posttool(context, tool),
              child: Text("Post"),
            )
          ],
        ),
      ),
    );
  }
}
