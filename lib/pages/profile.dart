// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n30store/pages/change_email.dart';
import 'package:n30store/pages/change_name.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:n30store/pages/change_pfp.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String usrName =
      "${FirebaseAuth.instance.currentUser!.displayName == "" ? "No name provided" : FirebaseAuth.instance.currentUser!.displayName}";
  var cUser = FirebaseAuth.instance.currentUser!;
  final storage = FirebaseStorage.instance;
  final pathReference = FirebaseStorage.instance.ref().child("person.png");
  final emailReset = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          Visibility(
            visible: !cUser.emailVerified,
            child: TextButton(
              onPressed: () {
                setState(() async {
                  try {
                    await cUser.sendEmailVerification().then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Email sent!"),
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
                });
              },
              onLongPress: () async {
                setState(() {
                  cUser.reload();
                  cUser = FirebaseAuth.instance.currentUser!;
                });
              },
              child: Text("Verify email"),
            ),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                            child: Text("Yes, log me out")),
                        FilledButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("No, cancel"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "${FirebaseAuth.instance.currentUser!.email == "" ? "No email Provided" : FirebaseAuth.instance.currentUser!.email}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Image.network(
              FirebaseAuth.instance.currentUser!.photoURL ??
                  "https://cdn-icons-png.flaticon.com/512/2815/2815428.png",
              loadingBuilder: (context, child, loadingProgress) {
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
            Text(
              usrName,
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "Edit you info",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ChangeEmail();
                          },
                        ));
                      },
                      icon: Icon(Icons.alternate_email_outlined),
                      label: Text("Change your email address"),
                    ),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ChangePFP();
                        },));
                      },
                      icon: Icon(Icons.switch_account_outlined),
                      label: Text("Change your Profile picture"),
                    ),
                    FilledButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Warning!"),
                              content: Text(
                                  "You are about to remove your current profile picture and revert to the  default one\nAre you sure?"),
                              actions: [
                                FilledButton(
                                    onPressed: () {
                                      cUser.updatePhotoURL(
                                          "https://firebasestorage.googleapis.com/v0/b/n30archstor.appspot.com/o/person.png?alt=media&token=68c3a265-93a5-4e8f-a04d-904ae19278b6");
                                      Navigator.pop(context);
                                    },
                                    child: Text("Yes, I am sure")),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("No"))
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.no_accounts_outlined),
                      label: Text("Remove your profile pricture"),
                    ),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ChangeName();
                          },
                        ));
                      },
                      icon: Icon(Icons.manage_accounts_outlined),
                      label: Text("Change your name"),
                    ),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "We will send you a link to your email to reset your password"),
                              content: TextField(
                                decoration: InputDecoration(
                                  hintText: "something@example.com",
                                  labelText: 'Current email',
                                ),
                                controller: emailReset,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No, cancel"),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    try {
                                      FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: emailReset.text.trim());
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "If the email is valid, you will recive a password reset link"),
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("$e"),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text("Okay"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.manage_accounts_outlined),
                      label: Text("Change your password"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        label: Text("Edit info"),
        icon: Icon(Icons.edit),
      ),
    );
  }
}
