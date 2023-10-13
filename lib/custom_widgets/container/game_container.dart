import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/custom_widgets/container/mini_game_container.dart';
import 'package:tic_tac_toe_pro/custom_widgets/game_widget/ticTacToe.dart';
import 'package:tic_tac_toe_pro/providers/game_providers.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

const ticTacToeColor = Colors.black;
const defaultFrameColor = Colors.black;
const disabledFrameColor = Colors.grey;

class GameBoxContainer extends StatefulWidget {
  const GameBoxContainer({super.key});

  @override
  State<GameBoxContainer> createState() => GameBoxContainerState();
}

class GameBoxContainerState extends State<GameBoxContainer> {
  List<bool> absorb = List.generate(9, (_) => false);
  List<Color> opacity = List.generate(9, (_) => defaultFrameColor);

  proGame(int childIndex) {
    List<bool> newAbsorb = List.generate(9, (_) => true);
    List<Color> newOpacity = List.generate(9, (_) => disabledFrameColor);

    int index = childIndex;

    for (int i = 0; i < 9; i++) {
      if (!context.read<GameProvider>().capturedBoxIndex.contains(index)) {
        break;
      } else if (!context.read<GameProvider>().capturedBoxIndex.contains(i)) {
        index = i;
        break;
      }
    }
    // this will control absorbable and index
    newAbsorb[index] = false;
    newOpacity[index] = defaultFrameColor;

    setState(() {
      absorb = newAbsorb;
      opacity = newOpacity;
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
            (index) => context.watch<GameProvider>().capturedBoxes[index] == ""
                ? AbsorbPointer(
                    absorbing: absorb[index],
                    child: TicTacToe(
                      borderColor: ticTacToeColor,
                      borderWidth: 3,
                      borderBool: ticTacToeBorder[index],
                      bgColor: Colors.transparent,
                      child: MiniGame(
                        parentIndex: index,
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
                        context.watch<GameProvider>().capturedBoxes[index],
                        style: GoogleFonts.fuggles(
                          textStyle: TextStyle(
                            fontSize: 84,
                            fontWeight: FontWeight.bold,
                            color: context
                                        .watch<GameProvider>()
                                        .capturedBoxes[index] ==
                                    player1.symbol
                                ? player1.color
                                : context
                                            .watch<GameProvider>()
                                            .capturedBoxes[index] ==
                                        player2.symbol
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
