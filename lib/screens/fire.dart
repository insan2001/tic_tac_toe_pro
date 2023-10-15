import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fire extends StatefulWidget {
  Fire({super.key});

  @override
  State<Fire> createState() => _FireState();
}

class _FireState extends State<Fire> {
  final docUser = FirebaseFirestore.instance.collection("room").doc("customID");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: docUser.snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          return TextButton(
              onPressed: () {
                // snapshot.data.data();
                print(snapshot.data!.data()?["name"]);
                docUser.set({
                  "joinedPlayer": {"id": "JoinedPlayerID"},
                  "isStarted": false
                });
                print("data added");
              },
              child: snapshot.data?.data()?["name"] == "insan"
                  ? Text("me")
                  : Text("others"));
        });
  }
}
