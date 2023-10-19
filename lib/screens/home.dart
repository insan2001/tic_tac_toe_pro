// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/titileText.dart';
import 'package:tic_tac_toe_pro/custom_widgets/custom_button/home_button.dart';
import 'package:tic_tac_toe_pro/custom_widgets/userProfile.dart';
import 'package:tic_tac_toe_pro/functions/authentication.dart';
import 'package:tic_tac_toe_pro/screens/user_details.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

const profileIcon = Icon(Icons.person);
const exitIcon = Icon(Icons.logout_outlined);
const IconData computer = Icons.computer;
const IconData player = Icons.person;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  late BuildContext processPopupContext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: blackAndWhitegredientBG),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                            height: 45,
                            width: 45,
                            child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UserDetailScreen())),
                                child: UserProfile())),
                        Spacer(),
                        TitleText(),
                        Spacer(),
                        IconButton(
                          onPressed: signOut,
                          icon: Icon(
                            Icons.exit_to_app,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                        Spacer(),
                      ],
                    )),
                Center(
                  child: SizedBox(
                    height: 400,
                    child: Column(
                      children: [
                        const Spacer(),
                        homeButton(computer, player, false, context),
                        const Spacer(),
                        homeButton(computer, player, true, context),
                        const Spacer(),
                        homeButton(player, player, false, context),
                        const Spacer(),
                        homeButton(player, player, true, context),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
