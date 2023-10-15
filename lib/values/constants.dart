import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/custom_widgets/container/game_container.dart';
import 'package:tic_tac_toe_pro/custom_widgets/game_widget/time.dart';
import 'package:uuid/uuid.dart';

class Player {
  final String symbol;
  final Color color;
  final Icon icon;
  String profileImg;
  String name;
  String ID;

  Player(
      this.symbol, this.color, this.icon, this.profileImg, this.name, this.ID);

  Map<String, String> playerJson() {
    return {
      "profileImg": this.profileImg,
      "name": this.name,
      "id": this.ID,
    };
  }

  jsonPlayer(jsonData) {
    name = jsonData["name"];
    profileImg = jsonData["profileImg"];
    ID = jsonData["id"];
  }
}

// player1 color
Color playerColor1 = Colors.blue;
// player2 color
Color playerColor2 = Colors.red;
// bot color
Color botColor = const Color.fromARGB(255, 255, 0, 0);
// Nobodies color
Color nobodyColor = Colors.orange;

String playerImg1 =
    "https://firebasestorage.googleapis.com/v0/b/tic-tac-toe-pro-99928755.appspot.com/o/myPicSquare.png?alt=media&token=b91612f1-4447-425c-b100-a3cd8d979923&_gl=1*11bxna*_ga*MTYxMTkxOTMwNi4xNjk2MjIxNTg5*_ga_CW55HF8NVT*MTY5NjkwODY1MS4xNi4xLjE2OTY5MDg3MzAuNDIuMC4w";
String playerImg2 =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgUNaoFwOOa3sOnMoc8CVUJ65bhS822etxVQ&usqp=CAU";

// setup players

late Player player;
late Player opponent;

List<List<bool>> ticTacToeBorder = [
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

const gameName = "Capture The Box";
final gameNameStyle = GoogleFonts.inriaSans(
    textStyle: const TextStyle(
  fontSize: 26,
  color: Colors.white,
));

Widget gameNameText = Text(gameName, style: gameNameStyle);

final timerkey = GlobalKey<CountDownTimerState>();
final gameBoxKey = GlobalKey<GameBoxContainerState>();

late bool proMode;
final String roomID = Uuid().v1();

final signUpStyle = GoogleFonts.openSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: Colors.white,
));
