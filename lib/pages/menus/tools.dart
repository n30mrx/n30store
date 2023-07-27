// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n30store/components/tool_item.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'add_tool.dart';

class ToolView extends StatelessWidget {
  ToolView({super.key});
  final tools = FirebaseFirestore.instance.collection("tools");
  final pubs = FirebaseFirestore.instance.collection("pubs");
  final cUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tools"),
      ),
      body: StreamBuilder(
        stream: tools.orderBy("time", descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // get the tool list
                final post = snapshot.data!.docs[index];
                return ToolItem(
                  toolName: post['name'],
                  toolTh: post['img'],
                  toolUrl: post['url'],
                  toolTime: post['time'],
                  toolIndex: index,
                  toolId: post['id'],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: SelectableText("An error has occured:\n${snapshot.error}"),
            );
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("\n\nLoading, please wait...")
            ],
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (cUser.email != "abas93931@gmail.com") {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Send a tool for review"),
                  content: Text(
                      "Hey! thanks for sharing\nIf you want to contribute too the tools library\nPlease contact us on @n30archbot  on telegram"),
                  actions: [
                    FilledButton(
                        onPressed: () {
                          launchUrlString("https://t.me/n30archbot");
                        },
                        child: Text("Open the bot")),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"))
                  ],
                );
              },
            );
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addtool(),
                ));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
