import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac_toe_pro/constants/constants.dart';
import 'package:tic_tac_toe_pro/functions/ads.dart';
import 'package:tic_tac_toe_pro/screens/options.dart';

class WinScreen extends StatefulWidget {
  final Icon playerIcon;
  final Color playerColor;
  final String winText;
  WinScreen(
      {super.key,
      required this.playerIcon,
      required this.playerColor,
      required this.winText});

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  late ConfettiController confettiController;
  BannerAd? banner;
  InterstitialAd? fullAd;
  // Winner Style

  TextStyle winnerStyle(pColor) => GoogleFonts.inriaSans(
          textStyle: TextStyle(
        fontSize: 24,
        color: pColor,
      ));

  @override
  void initState() {
    super.initState();
    createBannerAd();
    createFullAd();
    confettiController = ConfettiController(
      duration: Duration(seconds: 5),
    );
    widget.playerColor != noOneColor ? confettiController.play() : showFullAd();
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
        body: Container(
          decoration: BoxDecoration(
            gradient: mainBgGredient,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 100,
                    child: Center(
                      child: Text(
                        widget.winText,
                        style: winnerStyle(widget.playerColor),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        border: Border.all(
                          color: widget.playerColor,
                          width: 6,
                        ),
                      ),
                      child: widget.playerIcon,
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                  Spacer(),
                  Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: mainBgGredient,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showFullAd();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameOptions(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Spacer(),
                          Icon(Icons.home),
                          Spacer(),
                          Text(
                            "Home",
                            style: winnerStyle(widget.playerColor),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Center(
                child: ConfettiWidget(
                  numberOfParticles: 20,
                  confettiController: confettiController,
                  blastDirection: -pi / 2,
                  gravity: 0.1,
                  emissionFrequency: 0.1,
                ),
              ),
            ],
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
