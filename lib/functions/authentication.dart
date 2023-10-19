import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tic_tac_toe_pro/custom_widgets/custom_popup/screen_block.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

Future<bool> signOut() async {
  try {
    await GoogleSignIn().disconnect();
  } catch (_) {
    await auth.signOut();
  }
  return true;
}

Future<void> forgotPassword(
    BuildContext context, TextEditingController emailControl) async {
  try {
    processPopup(context);
    await auth
        .sendPasswordResetEmail(email: emailControl.text.trim())
        .then((_) => Navigator.pop(context, false));
    scafKey.currentState
        ?.showSnackBar(SnackBar(content: Text("Reset mail was sent.")));
  } on FirebaseAuthException catch (e) {
    scafKey.currentState
        ?.showSnackBar(SnackBar(content: Text(e.message ?? "")));
  }
}

Future signInWithGoogle(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    final googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      processPopup(context);
      final signInAuth = await googleSignInAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
        idToken: signInAuth.idToken,
        accessToken: signInAuth.accessToken,
      );
      await auth.signInWithCredential(credentials).then((_) {
        Navigator.pop(context, false);
        firestoreUser.set({});
        profile.putFile(File(profileLoc));
      });
    }
  } on PlatformException catch (e) {
    print("error");
    scafKey.currentState?.showSnackBar(SnackBar(content: Text(e.code)));
  } catch (e) {
    print(e);
  }
  navigatorKey.currentState?.popUntil((route) => route.isFirst);
}

Future signIn(BuildContext context, TextEditingController emailControl,
    TextEditingController passwordControl) async {
  try {
    processPopup(context);
    await auth
        .signInWithEmailAndPassword(
            email: emailControl.text.trim(),
            password: passwordControl.text.trim())
        .then((_) {
      Navigator.pop(context, false);
      firestoreUser.set({});
      profile.putFile(File(profileLoc));
    });
  } on FirebaseAuthException catch (e) {
    scafKey.currentState
        ?.showSnackBar(SnackBar(content: Text(e.message ?? "")));
  }
  navigatorKey.currentState?.popUntil((route) => route.isFirst);
}

Future signUp(BuildContext context, TextEditingController emailControl,
    TextEditingController passwordControl) async {
  try {
    processPopup(context);
    await auth
        .createUserWithEmailAndPassword(
      email: emailControl.text.trim(),
      password: passwordControl.text.trim(),
    )
        .then((_) {
      if (context.mounted) {
        Navigator.pop(context, false);
      }

      firestoreUser.set({});
      profile.putFile(File(profileLoc));
    });
  } on FirebaseAuthException catch (e) {
    scafKey.currentState
        ?.showSnackBar(SnackBar(content: Text(e.message ?? "")));
  }
  navigatorKey.currentState?.popUntil((route) => route.isFirst);
}
