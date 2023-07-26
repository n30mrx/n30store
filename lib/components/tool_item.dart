// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolItem extends StatelessWidget {
  final String toolName;
  final String toolTh;
  final String toolUrl;
  final Timestamp toolTime;
  final int toolIndex;
  final String toolId;

  ToolItem({
    super.key,
    required this.toolName,
    required this.toolTime,
    required this.toolTh,
    required this.toolUrl,
    required this.toolIndex,
    required this.toolId,
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
                toolName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Image.network(
                toolTh,
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
                    Uri.parse(toolUrl),
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
                              "Are you sure you want to delete this tool?",
                            ),
                            actions: [
                              FilledButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('tools')
                                      .doc(toolId)
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
