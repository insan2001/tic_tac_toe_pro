import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

const clockTime = 5;
int currentTime = 5;

class CountDownTimer extends StatefulWidget {
  final Player currentPlayer;
  final Function changePlayer;

  const CountDownTimer(
      {super.key, required this.currentPlayer, required this.changePlayer});

  @override
  State<CountDownTimer> createState() => CountDownTimerState();
}

class CountDownTimerState extends State<CountDownTimer> {
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTime > 1) {
        setState(() {
          currentTime--;
        });
      } else {
        setState(() {
          currentTime = clockTime;
        });
        widget.changePlayer();
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
            color: widget.currentPlayer.color,
            value: currentTime / clockTime,
            strokeWidth: 8,
          ),
          widget.currentPlayer.profileImg,
        ]),
      ),
    );
  }
}
