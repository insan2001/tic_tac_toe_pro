import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/custom_widgets/container/mini_game_container.dart';
import 'package:tic_tac_toe_pro/custom_widgets/game_widget/ticTacToe.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

const ticTacToeColor = Colors.black;
const defaultFrameColor = Colors.black;
const disabledFrameColor = Colors.black;

class GameBoxContainer extends StatefulWidget {
  final Player player;
  final Function stateSetterForGame;
  const GameBoxContainer(
      {super.key, required this.player, required this.stateSetterForGame});

  @override
  State<GameBoxContainer> createState() => GameBoxContainerState();
}

class GameBoxContainerState extends State<GameBoxContainer> {
  List<bool> absorb = List.generate(9, (_) => false);
  List<Color> opacity = List.generate(9, (_) => defaultFrameColor);

  selectedFrameColorChange(Color color, int index) {
    List<Color> newOpacity = List.generate(9, (_) => disabledFrameColor);
    newOpacity[index] = color;
    setState(() {
      opacity = newOpacity;
    });
  }

  proGame(int childIndex) {
    List<bool> newAbsorb = List.generate(9, (_) => true);

    int index = childIndex;

    for (int i = 0; i < 9; i++) {
      if (!capturedBoxIndex.contains(index)) {
        break;
      } else if (!capturedBoxIndex.contains(i)) {
        index = i;
        break;
      }
    }
    // this will control absorbable and index
    newAbsorb[index] = false;

    setState(() {
      absorb = newAbsorb;
    });
  }

  capturedBoxMarker(int parentIndex, String symbol) {
    setState(() {
      capturedBoxIndex.add(parentIndex);
      capturedBoxes[parentIndex] = symbol;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width - 16,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.count(
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          children: List<Widget>.generate(
            9,
            (index) => capturedBoxes[index] == ""
                ? AbsorbPointer(
                    absorbing: absorb[index],
                    child: TicTacToe(
                      borderColor: ticTacToeColor,
                      borderWidth: 3,
                      borderBool: ticTacToeBorder[index],
                      bgColor: Colors.transparent,
                      child: MiniGame(
                        player: widget.player,
                        parentIndex: index,
                        stateSetterForGame: widget.stateSetterForGame,
                        opacity: opacity[index],
                      ),
                    ),
                  )
                : TicTacToe(
                    borderColor: ticTacToeColor,
                    borderWidth: 3,
                    borderBool: ticTacToeBorder[index],
                    bgColor: Colors.transparent,
                    child: Center(
                      child: Text(
                        capturedBoxes[index],
                        style: GoogleFonts.fuggles(
                          textStyle: TextStyle(
                            fontSize: 84,
                            fontWeight: FontWeight.bold,
                            color: capturedBoxes[index] == player1.symbol
                                ? player1.color
                                : capturedBoxes[index] == player2.symbol
                                    ? player2.color
                                    : nobodyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
