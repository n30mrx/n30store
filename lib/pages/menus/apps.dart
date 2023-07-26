// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:n30store/components/app_item.dart';

import 'add_app.dart';

class AppView extends StatelessWidget {
  AppView({super.key});
  final apps = FirebaseFirestore.instance.collection("apps");
  final pubs = FirebaseFirestore.instance.collection("pubs");
  final cUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apps"),
      ),
      body: StreamBuilder(
        stream: apps.orderBy("time", descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // get the app list
                final post = snapshot.data!.docs[index];
                return AppItem(
                  appName: post['name'],
                  appTh: post['img'],
                  appUrl: post['url'],
                  appTime: post['time'],
                  appIndex: index,
                  appId: post['id'],
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
      floatingActionButton: Visibility(
        visible: cUser.email == "abas93931@gmail.com",
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addapp(),
                ));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
