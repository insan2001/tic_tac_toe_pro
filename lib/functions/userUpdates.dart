import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/custom_widgets/custom_popup/screen_block.dart';
import 'package:tic_tac_toe_pro/functions/storage.dart';
import 'package:tic_tac_toe_pro/providers/user_detail.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

delUpdate(String delFile, String newFile, Uint8List imgData) {
  File(delFile).delete();

  imageCache.clear();
  File(newFile).writeAsBytes(imgData).then((value) => print(newFile));
}

imagePicker(BuildContext context) async {
  Provider.of<UserProvider>(context, listen: false).changeProcess();

  final returnImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  if (returnImage != null) {
    processPopup(context);
    final imgData = await returnImage.readAsBytes();

    if (await File(profileLoc).exists()) {
      delUpdate(profileLoc, profileLoc2, imgData);
      await upload(profileLoc2, context)
          .then((value) => Navigator.pop(context));
    } else if (await File(profileLoc2).exists()) {
      delUpdate(profileLoc2, profileLoc, imgData);
      await upload(profileLoc, context).then((value) => Navigator.pop(context));
    }
    return "Profile updated";
  } else {
    return "No Image selected";
  }
}

deleteUserAccount() {
  firestoreUser.delete().then((_) => auth.currentUser?.delete()).then((_) {
    profile.delete();
  });
}
