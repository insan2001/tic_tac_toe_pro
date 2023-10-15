import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/providers/game_providers.dart';

const clockTime = 5;
int currentTime = 5;

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

  @override
  State<CountDownTimer> createState() => CountDownTimerState();
}

class CountDownTimerState extends State<CountDownTimer> {
  Timer? timer;

  startTimer() {
    final gameDetails = Provider.of<GameProvider>(context, listen: false);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTime > 1) {
        setState(() {
          currentTime--;
        });
      } else {
        setState(() {
          currentTime = clockTime;
        });
        gameDetails.changePlayer();
      }
    });
  }

  activateClock() {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      timer?.cancel();
      currentTime = clockTime;
      startTimer();
    } else {
      startTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(fit: StackFit.expand, children: [
          CircularProgressIndicator(
            color: context.watch<GameProvider>().currentPlayer.color,
            value: currentTime / clockTime,
            strokeWidth: 8,
          ),
          CircleAvatar(
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: context.read<GameProvider>().currentPlayer.profileImg,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
