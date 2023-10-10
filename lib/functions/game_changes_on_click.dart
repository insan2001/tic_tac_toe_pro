import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/custom_widgets/container/game_container.dart';
import 'package:tic_tac_toe_pro/custom_widgets/game_widget/time.dart';
import 'package:tic_tac_toe_pro/functions/win_checker.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

onClickHandler(
    int parentIndex,
    int childIndex,
    GlobalKey<CountDownTimerState> timerkey,
    GlobalKey<GameBoxContainerState> gameBoxKey,
    Player currentPlayer,
    bool proMode) {
  // set timer
  timerkey.currentState?.activateClock();

  if (winChecker(displayXOList[parentIndex])) {
    gameBoxKey.currentState
        ?.capturedBoxMarker(parentIndex, currentPlayer.symbol);
    if (winChecker(capturedBoxes)) {
      // navigate to win screen as win
    } else if (!capturedBoxes.contains("")) {
      // navigate to win screen as draw
    }
    // here checks for maingame win
  } else if (!displayXOList[parentIndex].contains("")) {
    gameBoxKey.currentState?.capturedBoxMarker(parentIndex, "!");
    if (!capturedBoxes.contains("")) {
      // navigate to win screen as draw
    }
  }
  // activate on pro mode
  proMode ? gameBoxKey.currentState?.proGame(childIndex) : null;
}
