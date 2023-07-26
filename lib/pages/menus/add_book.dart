// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBook extends StatelessWidget {
  AddBook({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController thumbnail = TextEditingController();
  final TextEditingController url = TextEditingController();
  final book = FirebaseFirestore.instance.collection('books').doc();

  void postBook(
      BuildContext context, DocumentReference<Map<String, dynamic>> books) {
    if (name.text.isEmpty | thumbnail.text.isEmpty | url.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill out all parameters")));
      return;
    } else {
      try {
        books.set({
          'name': name.text.trim(),
          'img': thumbnail.text.trim(),
          'url': url.text.trim(),
          'time': Timestamp.now(),
          'id': books.id
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
        title: Text("New book post"),
      ),
      body: Center(
        child: Column(
          children: [
            // Book name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Book name",
                  label: Text("Book name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // book thumbnail
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: thumbnail,
                decoration: InputDecoration(
                  hintText: "Book thumbnail",
                  label: Text("Book thumbnail"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // book url
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: url,
                decoration: InputDecoration(
                  hintText: "Book url",
                  label: Text("Book url"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Submit button
            FilledButton(
              onPressed: () => postBook(context, book),
              child: Text("Post"),
            )
          ],
        ),
      ),
    );
  }
}
