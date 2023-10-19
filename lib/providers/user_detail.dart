import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

class UserProvider extends ChangeNotifier {
  // it's not belong to this class
  bool process = false;

  String userName = auth.currentUser?.displayName ?? "No name";
  String userID = auth.currentUser?.uid ?? "";
  String userProfile = auth.currentUser?.photoURL ?? "";

  Future<void> changeName(String name) async {
    await auth.currentUser?.updateDisplayName(name);
    userName = name;
    notifyListeners();
  }

  void changeProcess() {
    process = !process;
    notifyListeners();
  }

  void changeProfile(String newLoc, String newLink) {
    userProfile = newLoc;
    auth.currentUser?.updatePhotoURL(newLink);
    notifyListeners();
  }
}
