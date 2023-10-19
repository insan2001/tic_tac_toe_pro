import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tic_tac_toe_pro/custom_widgets/container/game_container.dart';
import 'package:tic_tac_toe_pro/custom_widgets/game_widget/time.dart';
import 'package:uuid/uuid.dart';

class Player {
  String symbol;
  String profileImg;
  String name;
  String ID;

  Player(
    this.ID,
    this.name,
    this.profileImg,
    this.symbol,
  );

  Map<String, String> playerJson() {
    return {
      "id": this.ID,
      "name": this.name,
      "profileImg": this.profileImg,
      "symbol": this.symbol,
    };
  }

  jsonPlayer(jsonData) {
    name = jsonData["name"];
    profileImg = jsonData["profileImg"];
    ID = jsonData["id"];
    symbol = jsonData["symbol"];
  }
}

// player1 color
Color playerColor = Colors.blue;
// player2 color
Color opponentColor = Colors.red;
// Nobodies color
Color nobodyColor = Colors.orange;

const List<List<bool>> ticTacToeBorder = [
  // l,t,r,b
  [false, false, true, true],
  [true, false, true, true],
  [true, false, false, true],
  [false, true, true, true],
  [true, true, true, true],
  [true, true, false, true],
  [false, true, true, false],
  [true, true, true, false],
  [true, true, false, false],
];

Gradient blackAndWhitegredientBG = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    // Color.fromARGB(255, 43, 41, 41),
    Color.fromARGB(255, 59, 59, 59),
    Color.fromARGB(255, 37, 37, 37),
    Color.fromARGB(255, 92, 91, 91),
    Color.fromARGB(255, 126, 123, 123),
    Color.fromARGB(255, 92, 91, 91),
    Color.fromARGB(255, 87, 85, 85),
    Color.fromARGB(255, 51, 50, 50),
    Color.fromARGB(255, 37, 37, 37),
  ],
  tileMode: TileMode.mirror,
);

// game name
const gameName = "Capture The Box";
Widget gameNameText = Text(gameName,
    style: GoogleFonts.inriaSans(
        textStyle: const TextStyle(
      fontSize: 26,
      color: Colors.white,
    )));

// Global keys

final timerkey = GlobalKey<CountDownTimerState>();
final gameBoxKey = GlobalKey<GameBoxContainerState>();
final navigatorKey = GlobalKey<NavigatorState>();
final scafKey = GlobalKey<ScaffoldMessengerState>();

late bool proMode;
final String roomID = Uuid().v1();

// font styles

final authButtonStyle = GoogleFonts.openSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: Colors.white,
));

final userInfo = GoogleFonts.inriaSans(
    textStyle: TextStyle(
  fontSize: 18,
  color: Colors.black,
));

// app documents initialize

late Directory appFolder;
late String appDoc;
late String profileLoc;
late String profileLoc2;

initDoc() async {
  appFolder = await getApplicationDocumentsDirectory();
  appDoc = "${appFolder.path}/Documents";
  profileLoc = "$appDoc/profile.jpg";
  profileLoc2 = "$appDoc/profile2.jpg";
}

// firebase setups

final auth = FirebaseAuth.instance;
final storage = FirebaseStorage.instance.ref();
final profile = storage.child("${auth.currentUser?.uid}.jpg");
final firestoreUser =
    FirebaseFirestore.instance.collection("users").doc(auth.currentUser?.uid);
