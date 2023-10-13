import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/custom_widgets/container/game_container.dart';
import 'package:tic_tac_toe_pro/custom_widgets/game_widget/time.dart';
import 'package:tic_tac_toe_pro/functions/ads.dart';
import 'package:tic_tac_toe_pro/functions/game_changes_on_click.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  BannerAd? banner;

  @override
  void initState() {
    super.initState();
    whoPlays = player1;
    createBannerAd();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: gameNameText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(gradient: blackAndWhitegredientBG),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: CountDownTimer(
                key: timerkey,
              ),
            ),
            Expanded(
              flex: 3,
              child: GameBoxContainer(key: gameBoxKey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: banner == null
          ? Container(
              color: Colors.transparent,
              height: 10,
            )
          : Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 52,
              child: AdWidget(ad: banner!),
            ),
    );
  }
}
