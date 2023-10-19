import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/functions/game_changes_on_click.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

class GameProvider extends ChangeNotifier {
  List<List<String>> displayXOList =
      List.generate(9, (_) => List.generate(9, (_) => ""));
  List<List<bool>> colorList =
      List.generate(9, (_) => List.generate(9, (_) => false));

  List<String> capturedBoxes = List.generate(9, (_) => "");

  List<int> capturedBoxIndex = [];

  late Player currentPlayer;
  late bool isMePlays;

  void changePlayer() {
    // this current player will ulpdated based on id
    // this function update player based on firebase by changing player id
    currentPlayer = currentPlayer == me ? opponent : me;
    isMePlays = !isMePlays;
    notifyListeners();
  }

  void updateBoard(
    int parentIndex,
    int index,
    BuildContext context,
  ) {
    if (displayXOList[parentIndex][index] == "") {
      displayXOList[parentIndex][index] = currentPlayer.symbol;
      colorList[parentIndex][index] = true;

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
