import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

const playerInfoBg = Colors.black;
const playerInfoBorder = Colors.grey;
const playerInfoBorderWidth = 3.0;
const playerInfoCircular = 10.0;

class PlayerInfo extends StatelessWidget {
  final Player player;
  const PlayerInfo({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        gradient: blackAndWhitegredientBG,
        border:
            Border.all(color: playerInfoBorder, width: playerInfoBorderWidth),
        borderRadius: BorderRadius.circular(playerInfoCircular),
      ),
      child: Column(
        children: [
          const Spacer(),
          Text(
            "player.name",
            style: GoogleFonts.inriaSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: player.color,
              ),
            ),
          ),
          const Spacer(),
          player.icon,
          const Spacer(),
          Center(
            child: Text(
              player.symbol,
              style: GoogleFonts.fuggles(
                textStyle: TextStyle(
                  fontSize: 48,
                  color: player.color,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
