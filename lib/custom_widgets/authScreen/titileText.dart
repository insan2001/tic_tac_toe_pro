import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          gameName,
          textStyle: GoogleFonts.pacifico(
              textStyle: const TextStyle(
            fontSize: 36,
            color: Colors.white,
          )),
          colors: [
            Colors.blueAccent,
            Colors.greenAccent,
            Colors.redAccent,
          ],
          speed: Duration(seconds: 2),
        ),
      ],
      repeatForever: true,
    );
  }
}
