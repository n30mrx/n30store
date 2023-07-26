// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SkillItem extends StatelessWidget {
  final String skillName;
  final String skillTh;
  final String skillUrl;
  final Timestamp skillTime;
  final int skillIndex;
  final String skillId;

  SkillItem({
    super.key,
    required this.skillName,
    required this.skillTime,
    required this.skillTh,
    required this.skillUrl,
    required this.skillIndex,
    required this.skillId,
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
                skillName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Image.network(
                skillTh,
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
                    Uri.parse(skillUrl),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: Icon(Icons.message_outlined),
                label: Text("Contact"),
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
                              "Are you sure you want to delete this skill?",
                            ),
                            actions: [
                              FilledButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('skills')
                                      .doc(skillId)
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
