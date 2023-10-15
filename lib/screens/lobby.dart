import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/functions/jsonList.dart';
import 'package:tic_tac_toe_pro/providers/game_providers.dart';
import 'package:tic_tac_toe_pro/screens/game.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

class Lobby extends StatefulWidget {
  const Lobby({super.key});

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  late String profilePic;
  final room = FirebaseFirestore.instance.collection("room");
  final matchMaking =
      FirebaseFirestore.instance.collection("matchmaking").doc("customID");

  void navigate() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GameScreen(),
        ));
  }

  createRoom() {
    final newRoom = room.doc(roomID);
    newRoom.set({
      "board": listToJson(GameProvider().displayXOList),
      "opponent": {"id": "", "profile": ""},
      "player": {"id": userID, "profile": profilePic},
      "turn": userID,
      "isPlaying": false
    });
  }

  updateRoom(String roomID) {
    final newRoom = room.doc(roomID);
    newRoom.update({
      "opponent": {"id": userID, "profile": profilePic},
      "isPlaying": true,
    });
    navigate();
  }

  @override
  void initState() async {
    super.initState();

    matchMaking.get().then((DocumentSnapshot snapshot) {
      if (!snapshot.exists) {
        // create match making
        matchMaking.set({
          "owner": userID,
          "join": "",
          "room": roomID,
        });
        createRoom();
      } else {
        final data = snapshot.data() as Map;
        updateRoom(data["room"]);
        matchMaking.delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
            child: Row(
          children: [
            Flexible(
                child: Column(children: [
                  Text("Share this room code\n with your friend"),
                  TextButton(
                    onPressed: () {
                      //this will copy the room id
                    },
                    child: Text(roomID),
                  )
                ]),
                flex: 2),
            Flexible(
                child: IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                flex: 1)
          ],
        )), //this will have room key and share option
        Container(
          child: Row(children: [
            CircleAvatar(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: playerImg1,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Container(child: Text("Vs")),
            CircleAvatar(
              child: ClipOval(
                child: Icon(Icons.person_outline),
              ),
            ), // opponetn
          ]),
        ), // this have player waiting info
        Container(
          child: Column(
            children: [
              Text("Waiting for player to join"),
              StreamBuilder(
                  stream: room.doc(roomID).snapshots(),
                  builder: (context, snapshot) {
                    snapshot.data!.data()?["isPlaying"] ? navigate() : null;
                    return CircularProgressIndicator(color: Colors.amber);
                  })
            ],
          ),
        ), // circular process indicator
      ],
    ));
  }
}
