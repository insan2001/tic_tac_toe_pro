import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Player

class Player {
  final bool playerBool;
  final String symbol;
  final Color color;
  final Icon icon;
  final String who;

  Player(this.playerBool, this.symbol, this.color, this.icon, this.who);
}

// setup players

Player player1 = Player(true, "O", playerColor1,
    Icon(Icons.perm_identity_outlined, color: playerColor1), "human");
Player player2 = Player(false, "X", playerColor2,
    Icon(Icons.perm_identity_outlined, color: playerColor2), "human");
Player botPlayer = Player(
    false, "X", playerColor2, Icon(Icons.computer, color: botColor), "bot");

// Colors

// player1 color
Color playerColor1 = Colors.blue;
// player2 color
Color playerColor2 = Colors.red;
// bot color
Color botColor = Color.fromARGB(255, 255, 0, 0);
// mini game border color
Color frameBorder = Colors.grey;
// mini game bg color and won game bg
Color miniTicTacToeFill = Color.fromARGB(255, 37, 39, 41);
// main game border color
Color ticTacToeFrame = Color.fromARGB(255, 27, 123, 201);
// main game bg color
Color ticTacToeFill = Colors.black;
// app bar color
Color appBar = Color.fromARGB(255, 138, 141, 143);
// changing color
Color changeColor = Colors.black;
// color of game font
Color gameFontColor = Colors.white;
// game symbols color
Color gameSymbolColor = Colors.red;
// won box bg
Color wonBoxBg = Colors.black;
// nobody win
Color noOneColor = Colors.orange;

// gredient bg of main scaffold
Gradient mainBgGredient = LinearGradient(
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
// icons volor
Color iconColor = Colors.black;

// fonts

// Alertbox font
TextStyle alertBox = GoogleFonts.inriaSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: gameFontColor,
));

// Option screen text style
TextStyle textStyle = GoogleFonts.inriaSans(
    textStyle: TextStyle(
  fontSize: 18,
  color: gameFontColor,
));

// time

// next player change time
int clockTime = 5;
// when user or bot select a frame the color change time
int colorFade = 1;
// its the time take a bot to play
int botTime = 1;

// win line adjustment
const double adjustValue = 20;

// Values

List<bool> absorberS = List.generate(9, (_) => true);

// game text

String gameName = "Tic Tac Toe Pro";
TextStyle gameText = GoogleFonts.inriaSans(
    textStyle: TextStyle(
  fontSize: 26,
  color: Colors.black,
));
