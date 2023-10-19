import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/functions/userUpdates.dart';
import 'package:tic_tac_toe_pro/screens/authentication/authentication.dart';

Color gameFontColor = Colors.white;

TextStyle alertBox = GoogleFonts.inriaSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: gameFontColor,
));

Future<bool?> deleteUser(_context) async => showDialog<bool>(
      context: _context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          title: Text(
            "Delete account",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: Text(
            "Your process will be lost and can't recover. Do you want to delete?",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.black,
          elevation: 12,
          shadowColor: Colors.grey,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Authentication()));
                deleteUserAccount();
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
