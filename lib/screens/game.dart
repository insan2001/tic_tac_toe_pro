import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/custom_widgets/container/game_container.dart';
import 'package:tic_tac_toe_pro/custom_widgets/game_widget/time.dart';
import 'package:tic_tac_toe_pro/functions/game_changes_on_click.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

class GameScreen extends StatefulWidget {
  final bool proMode;
  const GameScreen({super.key, required this.proMode});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Player currentPlayer;
  final timerkey = GlobalKey<CountDownTimerState>();
  final gameBoxKey = GlobalKey<GameBoxContainerState>();

  changePlayeronTime() {
    setState(() {
      currentPlayer = currentPlayer == player1 ? player2 : player1;
      gameBoxKey.currentState?.opacity[previousIndex] = currentPlayer.color;
    });
  }

  changePlayerOnClick(int childIndex) {
    setState(() {
      currentPlayer = currentPlayer == player1 ? player2 : player1;
      gameBoxKey.currentState
          ?.selectedFrameColorChange(currentPlayer.color, childIndex);
    });
  }

  setStateForMainGame(int parentIndex, int childIndex) {
    onClickHandler(parentIndex, childIndex, timerkey, gameBoxKey, currentPlayer,
        widget.proMode);
    changePlayerOnClick(childIndex);
  }

  @override
  void initState() {
    super.initState();
    currentPlayer = player1;
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
                currentPlayer: currentPlayer,
                changePlayer: changePlayeronTime,
              ),
            ),
            Expanded(
              flex: 3,
              child: GameBoxContainer(
                key: gameBoxKey,
                player: currentPlayer,
                stateSetterForGame: setStateForMainGame,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
