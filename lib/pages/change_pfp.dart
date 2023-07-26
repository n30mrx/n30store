// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ChangePFP extends StatelessWidget {
  ChangePFP({super.key});
  final imgUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change profile picture")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "You will need to upload your profile picture to \nan external server and paste the link here.",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Image URL",
                hintText: "tip: use  0ho.la to upload your file",
                suffixIcon: Tooltip(
                  message: "Launch 0ho.la to upload a custom photo",
                  child: IconButton(
                    onPressed: () => launchUrlString(
                      'https://0ho.la',
                      mode: LaunchMode.externalApplication,
                    ),
                    icon: Icon(Icons.launch_outlined),
                  ),
                ),
                border: OutlineInputBorder(),
              ),
              controller: imgUrl,
            ),
            SizedBox(
              height: 10,
            ),
            FilledButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            imgUrl.text.trim(),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                          FilledButton.icon(
                            onPressed: () {
                              try {
                                FirebaseAuth.instance.currentUser!
                                    .updatePhotoURL(imgUrl.text.trim());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Done!"),
                                  ),
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("$e"),
                                  ),
                                );
                              }
                            },
                            icon: Icon(Icons.done),
                            label: Text("Set as my picture"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text("Preview and set picture"),
            ),
          ],
        ),
      ),
    );
  }
}
