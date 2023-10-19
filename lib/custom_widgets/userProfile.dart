import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/providers/user_detail.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: Colors.black)),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.black,
        backgroundImage: (context.watch<UserProvider>().userProfile ==
                    profileLoc) ||
                (context.watch<UserProvider>().userProfile == profileLoc2)
            ? Image.file(
                key: UniqueKey(),
                File(context.watch<UserProvider>().userProfile),
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.person),
                fit: BoxFit.cover,
              ).image
            : Image.network(context.watch<UserProvider>().userProfile).image,
      ),
    );
  }
}
