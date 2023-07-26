// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n30store/pages/menus/apps.dart';
import 'package:n30store/pages/menus/skills.dart';
import 'package:n30store/pages/menus/tools.dart';
import 'package:n30store/pages/profile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menus/books.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Hello, ${user.displayName == "" ? user.email : user.displayName}"),
        actions: [
          Visibility(
            visible: FirebaseAuth.instance.currentUser!.email ==
                "anonacc@n30arch.arch",
            child: Tooltip(
              message: "Log out",
              child: IconButton(
                icon: Icon(Icons.logout_outlined),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ),
          Visibility(
            visible: FirebaseAuth.instance.currentUser!.email !=
                "anonacc@n30arch.arch",
            child: Tooltip(
              message: "Show profile",
              child: IconButton(
                onPressed: () {
                  // FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ));
                },
                icon: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                shadowColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    height: 100,
                    child: TextButton.icon(
                      label: Text("Books"),
                      icon: Icon(Icons.library_books_outlined),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return BookView();
                          },
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                shadowColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    height: 100,
                    child: TextButton.icon(
                      label: Text("Apps"),
                      icon: Icon(Icons.android),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AppView();
                          },
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                shadowColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    height: 100,
                    child: TextButton.icon(
                      label: Text("Tools"),
                      icon: Icon(Icons.construction_outlined),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ToolView();
                          },
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                shadowColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    height: 100,
                    child: TextButton.icon(
                      label: Text("Skills"),
                      icon: Icon(Icons.work),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SkillView();
                          },
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showAboutDialog(
              context: context,
              applicationName: "N30store",
              applicationVersion: "1.0",
              applicationLegalese:
                  "This app was created by Mr. X under the license of MIT",
              children: [
                Row(
                  children: [
                    Text("GitHub link: "),
                    TextButton(
                      child: Text("https://github.com/n30mrx"),
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse("https://github.com/n30mrx"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Telegram link: "),
                    TextButton(
                      child: Text("https://t.me/n30arch"),
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse("https://t.me/n30arch"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    )
                  ],
                )
              ]);
        },
        label: Text("About"),
        icon: Icon(Icons.info_outline),
      ),
    );
  }
}
