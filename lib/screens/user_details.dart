import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/custom_widgets/custom_popup/delete_user.dart';
import 'package:tic_tac_toe_pro/custom_widgets/custom_popup/name_change.dart';
import 'package:tic_tac_toe_pro/custom_widgets/custom_popup/password_verify.dart';
import 'package:tic_tac_toe_pro/custom_widgets/userProfile.dart';
import 'package:tic_tac_toe_pro/functions/userUpdates.dart';
import 'package:tic_tac_toe_pro/providers/user_detail.dart';
import 'package:tic_tac_toe_pro/screens/authentication/authentication.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

class UserDetailScreen extends StatefulWidget {
  UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: blackAndWhitegredientBG),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Flexible(
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Done"))),
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                UserProfile(),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue),
                                    child: context.watch<UserProvider>().process
                                        ? CircularProgressIndicator(
                                            color: Colors.white)
                                        : IconButton(
                                            onPressed: () async {
                                              await imagePicker(context)
                                                  .then((value) {
                                                Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .changeProcess();
                                                scafKey.currentState
                                                    ?.showSnackBar(SnackBar(
                                                        content: Text(value)));
                                              });
                                            },
                                            icon: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.image,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              Flexible(
                                  flex: 1,
                                  child: Text("User name :", style: userInfo)),
                              SizedBox(width: 20),
                              Flexible(
                                flex: 2,
                                child: Text(
                                  context.watch<UserProvider>().userName,
                                  style: userInfo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            right: 0,
                            child: IconButton(
                                onPressed: () {
                                  nameChangePopup(context);
                                },
                                icon: Icon(Icons.edit)))
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    if (auth.currentUser?.providerData[0].providerId !=
                        "google.com") {
                      print(auth.currentUser?.providerData[0].providerId);
                      deleteWithPassword(context).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Authentication()));
                        deleteUserAccount();
                      });
                    } else {
                      print(auth.currentUser?.providerData[0].providerId);
                      deleteUser(context);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Delete account",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
