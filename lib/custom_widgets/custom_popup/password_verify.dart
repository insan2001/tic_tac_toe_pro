import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/passwordTextField.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

Color gameFontColor = Colors.white;

TextStyle alertBox = GoogleFonts.inriaSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: gameFontColor,
));

Future<bool?> deleteWithPassword(_context) async => showDialog<bool>(
      context: _context,
      builder: (context) {
        final control = TextEditingController();
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
            "Verify your password to delete",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: PasswordTextField(controller: control),
          backgroundColor: Colors.grey,
          elevation: 12,
          shadowColor: Colors.grey,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                final credentials = EmailAuthProvider.credential(
                    email: auth.currentUser?.email ?? "",
                    password: control.text.trim());
                try {
                  auth.currentUser?.reauthenticateWithCredential(credentials);
                  auth.currentUser?.delete();
                } catch (e) {
                  print(e);
                  scafKey.currentState
                      ?.showSnackBar(SnackBar(content: Text("Wrong password")));
                }
              },
              child: Text(
                "Delete",
                style: alertBox,
              ),
            ),
          ],
        );
      },
    );
