import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/functions/authentication.dart';

Color gameFontColor = Colors.white;

TextStyle alertBox = GoogleFonts.inriaSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: gameFontColor,
));

Future<bool?> signOutPopup(_context) async => showDialog<bool>(
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
            "Sign out",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: Flexible(
            child: Text(
              "Do you want to sign out?",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 12,
          shadowColor: Colors.grey,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                signOut();
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
