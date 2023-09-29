import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe_pro/constants/constants.dart';
import 'package:tic_tac_toe_pro/functions/ads.dart';
import 'package:tic_tac_toe_pro/functions/mini_tic_tac_toe.dart';
import 'package:tic_tac_toe_pro/functions/win.dart';
import 'package:tic_tac_toe_pro/screens/win.dart';

Future<bool?> showAlert(_context) async => showDialog<bool>(
      context: _context,
      builder: (context) {
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
            "Quit game!",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: Text(
            "Your process will be lost! Do you want to quit?",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: Colors.black,
          elevation: 12,
          shadowColor: Colors.grey,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                "Yes",
                style: alertBox,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                "no",
                style: alertBox,
              ),
            ),
          ],
        );
      },
    );

class TicTacToe extends StatefulWidget {
  // turn on or off countdown timer
  final bool time;
  // play with bot or not
  final bool botOn;
  // can place in any box or not(this is the started concept)
  final bool allBoard;
  final List nameList;

  /*
Possible combinations

bot - allBoard(true) (play with bot in all box)
time - allBoard(true) (Two offline players in all box)
bot - allBoard(false) (play with bot in selected box)
time - allBoard(false) (Two offline players in selected box)

Note :  whenever player play with bot there is no need for
        timer eventhogh player can play with a time limit

*/

  TicTacToe({
    super.key,
    required this.time,
    required this.botOn,
    required this.allBoard,
    required this.nameList,
  });

  @override
  State<TicTacToe> createState() => TicTacToeState();
}

class TicTacToeState extends State<TicTacToe> {
  late String playerName = widget.nameList[0];
  //for temproray usage outside
  int temp = 0;
  // timer
  Timer? timer;
  int maxTime = clockTime;

  Player currentPlayer = player1;
  // this will used for change player
  bool player = true;
  // it will selected through the previous input of user
  late int currentGameBox;

  // global key set for access mini game
  final globekey0 = GlobalKey<MiniTicTacToeState>();
  final globekey1 = GlobalKey<MiniTicTacToeState>();
  final globekey2 = GlobalKey<MiniTicTacToeState>();
  final globekey3 = GlobalKey<MiniTicTacToeState>();
  final globekey4 = GlobalKey<MiniTicTacToeState>();
  final globekey5 = GlobalKey<MiniTicTacToeState>();
  final globekey6 = GlobalKey<MiniTicTacToeState>();
  final globekey7 = GlobalKey<MiniTicTacToeState>();
  final globekey8 = GlobalKey<MiniTicTacToeState>();

  // this is for references of absorbers and opacity
  List<bool> absorbers = absorberS;
  List<double> opacity = opacitY;

  // this is for update in UI
  List<bool> _absorbers = List.generate(9, (index) => false);
  List<double> _opacity = List.generate(9, (_) => 1);

  // used for create new absorbers
  late List<bool> newAbsorbers;
  late List<double> newOpacity;

  // this will have the won boxes and draw boxes
  List<int> captured = [];

  // this have the main game references
  List<String> mainFrame = List.generate(9, (_) => "");

  // this function will decide weather draw mini game or containter according to the state of win
  Widget mainBox(int index) {
    // Globalkey sets
    List<GlobalKey> globeKeys = [
      globekey0,
      globekey1,
      globekey2,
      globekey3,
      globekey4,
      globekey5,
      globekey6,
      globekey7,
      globekey8
    ];
    // chck for won or draw boxes
    if (!captured.contains(index)) {
      return AbsorbPointer(
        absorbing: _absorbers[index],
        child: Opacity(
          opacity: _opacity[index],
          child: Padding(
            padding: const EdgeInsets.all(1.5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: ticTacToeFrame,
              )),
              child: MiniTicTacToe(
                key: globeKeys[index],
                player: currentPlayer,
                refresh: refresh,
                timeOut: timeOut,
                index: index,
                won: false,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              mainFrame[index],
              style: symbolStyle,
            ),
          ));
    }
  }

  void timeOut() {
    if (maxTime > 1) {
      setState(() {
        maxTime--;
      });
    } else {
      // if bot is on bot will play
      widget.botOn ? bot() : changePlayer();
      setState(() {
        maxTime = clockTime;
      });
    }
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) timeOut();
    });
  }

  // it will change the player after each click
  changePlayer() {
    if (player) {
      player = !player;

      setState(() {
        playerName = !widget.botOn ? widget.nameList[1] : "Bot";
        currentPlayer = widget.botOn ? botPlayer : player2;
      });
    } else {
      player = !player;
      setState(() {
        playerName = widget.nameList[0];
        currentPlayer = player1;
      });
    }
  }

  // player win

  // it will manage all play events like win, draw and change player

  void play(int userClicked, List<String> displayXO, int index, bool botPlay) {
    // it must be run first otherwise absorbale will have issues
    bool win = winChecker(displayXO);
    if (win) {
      // when user win a box it add it to captured and update it in mainFrame
      captured.add(index);
      mainFrame[index] = currentPlayer.symbol;
      opacity[index] = 1;
      if (captured.length > 2) {
        if (winChecker(mainFrame)) {
          showFullAd();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WinScreen(
                playerIcon: currentPlayer.icon,
                playerColor: currentPlayer.color,
              ),
            ),
          );
        }
      }
    } else if (!displayXO.contains("")) {
      // do after game got filled without won
      captured.add(index);
      mainFrame[index] = "!";
      opacity[index] = 1;
    }
    // check for draw
    if (captured.length == 9) {
      showFullAd();
      // Nobody wins
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WinScreen(
            playerIcon: Icon(
              Icons.question_mark,
              color: Colors.orange,
            ),
            playerColor: Colors.orange,
          ),
        ),
      );
    }

    // check for timer is running or not
    if (widget.time) {
      final isRunning = timer == null ? false : timer!.isActive;
      if (isRunning) {
        timer?.cancel();
        maxTime = clockTime;
        startTimer();
      } else
        startTimer();
    }

    // when user select the index of captured then it will assign new box to play
    if (captured.contains(userClicked)) {
      for (temp; temp < 9; temp++) {
        if (!captured.contains(temp)) {
          userClicked = temp;
          break;
        }
      }
      temp = 0;
    }
    // change the opacity of absorbable as disabledOpacity
    if (!widget.allBoard) {
      newOpacity = List.from(opacity);
      newOpacity[userClicked] = 1;

      // change the absorbable
      newAbsorbers = List.from(absorbers);
      newAbsorbers[userClicked] = botPlay ? false : true;
    } else {
      newOpacity = _opacity;
      List<bool> absorbers_ = List.generate(9, (index) => false);
      newAbsorbers = botPlay ? absorbers_ : absorberS;
    }

    // this is for set state on user clicked
    setState(() {
      _opacity = newOpacity;
      _absorbers = newAbsorbers;
      currentGameBox = widget.allBoard ? index : userClicked;
    });

    // first user will changed at the last therefore other process will not affected
    changePlayer();
  }

  int botPlay(displayXo) {
    int _temp = Random().nextInt(8);
    int currentFrame = widget.allBoard ? Random().nextInt(8) : currentGameBox;

    bool found = false;
    while (!found) {
      if (displayXo[_temp] == "") {
        displayXo[_temp] = currentPlayer.symbol;
        play(_temp, displayXo, currentFrame, true);
        found = true;
      } else {
        _temp = Random().nextInt(8);
      }
    }
    return _temp;
  }

  // this is for bot play
  void bot() async {
    List<String> displayXo = [];
    int gesterIndex;
    // by this bot can play in a random mainbox
    if (widget.allBoard) {
      currentGameBox = Random().nextInt(8);
      while (captured.contains(currentGameBox)) {
        currentGameBox = Random().nextInt(8);
      }
    }

    // here bot delay some time to feel like real player
    await Future.delayed(
      Duration(
        seconds: botTime,
      ),
    );

    // this will access the mini game
    // get the displayXO value
    // activate the guesterTap for the highlighted color
    if (this.mounted) {
      if (currentGameBox == 0) {
        displayXo = globekey0.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey0.currentState?.gesterTap(gesterIndex);
      } else if (currentGameBox == 1) {
        displayXo = globekey1.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey1.currentState?.gesterTap(gesterIndex);
      } else if (currentGameBox == 2) {
        displayXo = globekey2.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey2.currentState?.gesterTap(gesterIndex);
      } else if (currentGameBox == 3) {
        displayXo = globekey3.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey3.currentState?.gesterTap(gesterIndex);
      } else if (currentGameBox == 4) {
        displayXo = globekey4.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey4.currentState?.gesterTap(gesterIndex);
      } else if (currentGameBox == 5) {
        displayXo = globekey5.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey5.currentState?.gesterTap(gesterIndex);
      } else if (currentGameBox == 6) {
        displayXo = globekey6.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey6.currentState?.gesterTap(gesterIndex);
      } else if (currentGameBox == 7) {
        displayXo = globekey7.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey7.currentState?.gesterTap(gesterIndex);
      } else if (currentGameBox == 8) {
        displayXo = globekey8.currentState!.displayXO;
        gesterIndex = botPlay(displayXo);
        globekey8.currentState?.gesterTap(gesterIndex);
      }
    }
  }

  // this will handle the after user clicked events
  // userClicked - this will return index of which box user tapped
  // displayXO - get the filled boxes from game to check for win
  void refresh(int userClicked, List<String> displayXO, int index) {
    play(userClicked, displayXO, index, widget.botOn ? false : true);
    if (widget.botOn) bot();
  }

  @override
  void initState() {
    super.initState();
    createFullAd();
    createBannerAd();
  }

  BannerAd? banner;
  InterstitialAd? fullAd;

  void createBannerAd() {
    banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.BannerAdUnitId!,
      listener: AdMobService.bannerListener,
      request: AdRequest(),
    )..load();
  }

  void createFullAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.InterstitialAdUnitId!,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => fullAd = ad,
        onAdFailedToLoad: (LoadAdError error) => fullAd = null,
      ),
    );
  }

  void showFullAd() {
    if (fullAd != null) {
      fullAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createFullAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createFullAd();
        },
      );
      fullAd!.show();
    }
  }

  Widget getTimer() {
    return widget.time
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(fit: StackFit.expand, children: [
              CircularProgressIndicator(
                color: circularProgress,
                value: maxTime / clockTime,
                backgroundColor: circularProgressBG,
                strokeWidth: 8,
              ),
              Center(
                child: Text(
                  "$maxTime",
                  style: symbolStyle,
                ),
              ),
            ]),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    // generate 9 mainBox
    List<Widget> mainBoxes =
        List<Widget>.generate(9, (index) => mainBox(index));

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final shoudPop = await showAlert(context);
          return shoudPop ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appBar,
            title: Text(gameName),
            centerTitle: true,
            leading: IconButton(
              onPressed: () async {
                bool next = await showAlert(context) ?? false;
                if (next) Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(gradient: mainBgGredient),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  // This is for top (Show player details, game details)
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: getTimer(),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.grey, width: 3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 120,
                            width: 100,
                            child: Column(
                              children: [
                                Spacer(),
                                Text(
                                  playerName,
                                  style: GoogleFonts.inriaSans(
                                      textStyle: TextStyle(
                                    fontSize: 10,
                                    color: currentPlayer.color,
                                  )),
                                ),
                                Spacer(),
                                Icon(
                                  (widget.botOn &&
                                          currentPlayer.symbol ==
                                              player2.symbol)
                                      ? Icons.computer
                                      : Icons.perm_identity_outlined,
                                  color: currentPlayer.color,
                                  size: 35,
                                ),
                                Center(
                                  child: Text(
                                    currentPlayer.symbol,
                                    style: symbolStyle,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  // This is the main body part where tictactoe created
                  Container(
                    height: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      crossAxisCount: 3,
                      // set scroll false
                      physics: NeverScrollableScrollPhysics(),
                      children: mainBoxes,
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  // This is for set timer
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
      ),
    );
  }
}
