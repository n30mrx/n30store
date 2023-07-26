// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addskill extends StatelessWidget {
  Addskill({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController thumbnail = TextEditingController();
  final TextEditingController url = TextEditingController();
  final skill = FirebaseFirestore.instance.collection('skills').doc();

  void postskill(
      BuildContext context, DocumentReference<Map<String, dynamic>> skills) {
    if (name.text.isEmpty | thumbnail.text.isEmpty | url.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill out all parameters")));
      return;
    } else {
      try {
        skills.set({
          'name': name.text.trim(),
          'img': thumbnail.text.trim(),
          'url': url.text.trim(),
          'time': Timestamp.now(),
          'id': skills.id
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
        title: Text("New skill post"),
      ),
      body: Center(
        child: Column(
          children: [
            // skill name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "skill name",
                  label: Text("skill name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // skill thumbnail
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: thumbnail,
                decoration: InputDecoration(
                  hintText: "skill thumbnail",
                  label: Text("skill thumbnail"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // skill url
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: url,
                decoration: InputDecoration(
                  hintText: "skill url",
                  label: Text("skill url"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Submit button
            FilledButton(
              onPressed: () => postskill(context, skill),
              child: Text("Post"),
            )
          ],
        ),
      ),
    );
  }
}
