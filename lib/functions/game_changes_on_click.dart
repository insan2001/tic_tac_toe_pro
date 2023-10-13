import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/functions/win_checker.dart';
import 'package:tic_tac_toe_pro/providers/game_providers.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

onClickHandler(int parentIndex, int childIndex, BuildContext context) {
  // set timer
  timerkey.currentState?.activateClock();

  final gameDetails = context.read<GameProvider>();

  if (winChecker(gameDetails.displayXOList[parentIndex])) {
    gameDetails.onCapture(parentIndex, gameDetails.currentPlayer.symbol);
    if (winChecker(gameDetails.capturedBoxes)) {
      // navigate to win screen as win
    } else if (!gameDetails.capturedBoxes.contains("")) {
      // navigate to win screen as draw
    }
    // here checks for maingame win
  } else if (!gameDetails.displayXOList[parentIndex].contains("")) {
    gameDetails.onCapture(parentIndex, "!");
    if (!gameDetails.capturedBoxes.contains("")) {
      // navigate to win screen as draw
    }
  }
  // activate on pro mode
  proMode ? gameBoxKey.currentState?.proGame(childIndex) : null;
  gameDetails.changePlayer();
}
