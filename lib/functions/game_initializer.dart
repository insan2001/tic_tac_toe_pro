import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/providers/game_providers.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

void initPlayers(BuildContext context, String roomid) {
  final docUser = FirebaseFirestore.instance.collection("room").doc(roomid);
  final game = Provider.of<GameProvider>(context, listen: false);
  late Map<String, dynamic> playersData;
  docUser.get().then((snap) {
    playersData = snap.data() ?? {};
  });

  String whoIsMe =
      playersData["owner"]["id"] == auth.currentUser?.uid ? "owner" : "player";
  String whoIsOpponent =
      playersData["owner"]["id"] == auth.currentUser?.uid ? "player" : "owner";

  Map<String, dynamic> myData = playersData[whoIsMe];
  Map<String, dynamic> opponentData = playersData[whoIsOpponent];

  // init symbol from firebase
  me =
      Player(myData["id"], myData["name"], myData["picture"], myData["symbol"]);
  opponent = Player(opponentData["id"], opponentData["name"],
      opponentData["picture"], opponentData["symbol"]);

  bool isMyturn = playersData["turn"] == myData["id"];

  // set up current player in user provider
  game.currentPlayer = isMyturn ? me : opponent;
  //  isPlayer;
  game.isMePlays = isMyturn ? true : false;
}
