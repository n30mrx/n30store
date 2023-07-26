// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookItem extends StatelessWidget {
  final String bookName;
  final String bookTh;
  final String bookUrl;
  final Timestamp bookTime;
  final int bookIndex;
  final String bookId;

  BookItem({
    super.key,
    required this.bookName,
    required this.bookTime,
    required this.bookTh,
    required this.bookUrl,
    required this.bookIndex,
    required this.bookId,
  });

  final cUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                bookName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Image.network(
                bookTh,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              FilledButton.icon(
                onPressed: () {
                  launchUrl(
                    Uri.parse(bookUrl),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: Icon(Icons.download),
                label: Text("Download"),
              ),
              Visibility(
                visible: cUser!.email == "abas93931@gmail.com",
                child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Are you sure you want to delete this book?",
                            ),
                            actions: [
                              FilledButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('books')
                                      .doc(bookId)
                                      .delete();
                                  Navigator.pop(context);
                                },
                                child: Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("No"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete_outline),
                    label: Text("Delete")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
