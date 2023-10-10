import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/custom_widgets/custom_button/home_button.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

const profileIcon = Icon(Icons.person);
const exitIcon = Icon(Icons.logout_outlined);
const IconData computer = Icons.computer;
const IconData player = Icons.person;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: gameNameText,
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: profileIcon),
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(), icon: exitIcon)
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: blackAndWhitegredientBG),
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
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
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
