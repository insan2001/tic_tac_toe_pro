import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/constants/constants.dart';
import 'package:tic_tac_toe_pro/screens/options.dart';

class WinScreen extends StatefulWidget {
  final Icon playerIcon;
  final Color playerColor;
  WinScreen({super.key, required this.playerIcon, required this.playerColor});

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  // Winner Style
  TextStyle winnerStyle(pColor) => GoogleFonts.fuggles(
          textStyle: TextStyle(
        fontSize: 48,
        color: pColor,
      ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: mainBgGredient,
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2 - 100,
                child: Center(
                  child: Text(
                    "Winner!!!",
                    style: winnerStyle(widget.playerColor),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(
                    color: widget.playerColor,
                    width: 6,
                  ),
                ),
                child: widget.playerIcon,
              ),
              Container(
                color: Colors.blue,
              ),
              Spacer(),
              Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: mainBgGredient,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameOptions(),
                      ),
                    );
                  },
                  child: Text(
                    "Home",
                    style: winnerStyle(widget.playerColor),
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
