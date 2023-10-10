import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color gameFontColor = Colors.white;

TextStyle alertBox = GoogleFonts.inriaSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: gameFontColor,
));

Future<bool?> showAlert(_context) async => showDialog<bool>(
      context: _context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(
            bottom: 10,
            right: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          title: Text(
            "Quit game!",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: Text(
            "Your process will be lost! Do you want to quit?",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.black,
          elevation: 12,
          shadowColor: Colors.grey,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                "Yes",
                style: alertBox,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                "no",
                style: alertBox,
              ),
            ),
          ],
        );
      },
    );
