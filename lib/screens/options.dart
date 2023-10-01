import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_version/new_version.dart';
import 'package:tic_tac_toe_pro/constants/constants.dart';
import 'package:tic_tac_toe_pro/functions/ads.dart';
import 'package:tic_tac_toe_pro/functions/dataIO.dart';
import 'package:tic_tac_toe_pro/screens/ticTacToe.dart';

TextField userName(control, String hint) {
  return TextField(
    controller: control,
    maxLength: 15,
    decoration: InputDecoration(
        hintText: hint, icon: Icon(Icons.perm_identity_outlined)),
  );
}

// get username with a popup
getUserName(context) async {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  _controller1.text = await dataIO.getUserName1() ?? "";
  _controller2.text = await dataIO.getUserName2() ?? "";

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Enter players name"),
      content: Container(
        height: 150,
        child: Column(
          children: [
            userName(_controller1, "Enter your name"),
            userName(_controller2, "Enter 2nd player name"),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            dataIO.setUserName1(
                _controller1.text != "" ? _controller1.text : "Player 1");
            dataIO.setUserName2(
                _controller2.text != "" ? _controller2.text : "Player 2");
            Navigator.pop(context);
          },
          child: Text("Save"),
        )
      ],
    ),
  );
}

Future<List<String>> getNames() async {
  List<String> names = [];
  String name1 = await dataIO.getUserName1();
  String name2 = await dataIO.getUserName2();
  names.add(name1);
  names.add(name2);
  return names;
}

class GameOptions extends StatefulWidget {
  GameOptions({super.key});

  @override
  State<GameOptions> createState() => _GameOptionsState();
}

class _GameOptionsState extends State<GameOptions> {
  BannerAd? banner;

  Future<String> getPlayer(int i) async =>
      i == 1 ? await dataIO.getUserName1() : await dataIO.getUserName2();

  Widget buttons(String text, IconData icon1, IconData icon2, time, botOn,
      allBoard, _context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            List<String> nameList = await getNames();
            if (!mounted) return;
            Navigator.push(
              _context,
              MaterialPageRoute(
                builder: (context) => TicTacToe(
                  time: time,
                  botOn: botOn,
                  allBoard: allBoard,
                  nameList: nameList,
                ),
              ),
            );
          },
          child: Container(
            width: 200,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: mainBgGredient,
              border: Border.all(
                width: 1,
                color: Colors.blueGrey,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(icon1, color: Colors.white),
                      Spacer(),
                      Text(
                        "VS",
                        style: textStyle,
                      ),
                      Spacer(),
                      Icon(icon2, color: Colors.white),
                      Spacer(),
                    ],
                  ),
                ),
                Text(
                  text,
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void checkVersion() {
    final newVersion = NewVersion(androidId: "com.insanj.tttp");
    newVersion.showAlertIfNecessary(context: context);
  }

  @override
  void initState() {
    super.initState();
    createBannerAd();
    checkVersion();
  }

  void createBannerAd() {
    banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.BannerAdUnitId!,
      listener: AdMobService.bannerListener,
      request: AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              gameName,
              style: gameText,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                getUserName(context);
              },
              icon: Icon(
                Icons.perm_identity_outlined,
                color: iconColor,
              ),
            ),
            backgroundColor: appBar,
            actions: [
              IconButton(
                onPressed: () {
                  exit(0);
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: iconColor,
                ),
              ),
            ]),
        body: Container(
          decoration: BoxDecoration(
            gradient: mainBgGredient,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Spacer(),
                buttons("(Pro)", Icons.computer, Icons.perm_identity_outlined,
                    false, true, false, context),
                buttons("(Normal)", Icons.computer,
                    Icons.perm_identity_outlined, false, true, true, context),
                buttons("(Pro)", Icons.perm_identity_outlined,
                    Icons.perm_identity_outlined, true, false, false, context),
                buttons("(Normal)", Icons.perm_identity_outlined,
                    Icons.perm_identity_outlined, true, false, true, context),
                Spacer(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: banner == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 52,
                child: AdWidget(ad: banner!),
              ),
      ),
    );
  }
}
