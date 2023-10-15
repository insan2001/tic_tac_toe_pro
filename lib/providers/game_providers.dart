import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/functions/game_changes_on_click.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

class GameProvider extends ChangeNotifier {
  List<List<String>> displayXOList =
      List.generate(9, (_) => List.generate(9, (_) => ""));

  List<String> capturedBoxes = List.generate(9, (_) => "");
  List<int> capturedBoxIndex = [];

  Player currentPlayer = whoPlays;

  void changePlayer() {
    currentPlayer = currentPlayer == player ? opponent : player;
    notifyListeners();
  }

  void updateBoard(int parentIndex, int index, BuildContext context,
      Function(int index) onTapColorChange) {
    if (displayXOList[parentIndex][index] == "") {
      displayXOList[parentIndex][index] = currentPlayer.symbol;
      onTapColorChange(index);
      onClickHandler(parentIndex, index, context);
      notifyListeners();
    }
  }

  void onCapture(int parentIndex, String symbol) {
    capturedBoxIndex.add(parentIndex);
    capturedBoxes[parentIndex] = symbol;
    notifyListeners();
  }
}
