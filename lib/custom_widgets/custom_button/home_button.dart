import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/screens/game.dart';

const homeButtonGredient = LinearGradient(
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

const homeButtonGredientPro = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    // Color.fromARGB(255, 43, 41, 41),
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 223, 10, 10),
    Color.fromARGB(255, 179, 24, 24),
    Color.fromARGB(255, 110, 27, 27),
    Color.fromARGB(255, 110, 27, 27),
    Color.fromARGB(255, 179, 24, 24),
    Color.fromARGB(255, 223, 10, 10),
    Color.fromARGB(255, 255, 0, 0),
  ],
  tileMode: TileMode.mirror,
);

const homeButtonTextColor = Colors.white;
const homeButtonIconColor = Colors.white;
const homeButtonBorderColor = Colors.blueGrey;

TextStyle homeButtonTextStyle = GoogleFonts.inriaSans(
    textStyle: const TextStyle(
  fontSize: 18,
  color: Colors.white,
));

Widget homeButton(
    IconData icon1, IconData icon2, bool mode, BuildContext context) {
  // mode true for pro
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GameScreen(proMode: mode),
          ));
    },
    child: Container(
      width: 200,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: mode ? homeButtonGredientPro : homeButtonGredient,
        border: Border.all(
          width: 1,
          color: homeButtonBorderColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Spacer(),
            Icon(icon1, color: homeButtonIconColor),
            const Spacer(),
            Text(
              "VS",
              style: homeButtonTextStyle,
            ),
            const Spacer(),
            Icon(icon2, color: homeButtonIconColor),
            const Spacer(),
          ],
        ),
      ),
    ),
  );
}
