import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/providers/user_detail.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

Future<bool> upload(String loc, BuildContext context) async {
  final update = Provider.of<UserProvider>(context, listen: false);
  try {
    await profile.putFile(File(loc));
  } catch (e) {
    await profile.delete();
    await profile.putFile(File(loc)).then((_) => null);
  }
  update.changeProfile(loc, await profile.getDownloadURL());
  return true;
}
