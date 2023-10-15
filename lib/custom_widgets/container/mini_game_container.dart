import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/providers/game_providers.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:tic_tac_toe_pro/custom_widgets/game_widget/ticTacToe.dart';
import 'package:tic_tac_toe_pro/values/variable.dart';

const double borderWidth = 1.5;
const Color borderColor = Colors.black;
const Color containerBgColor = Color.fromARGB(255, 37, 39, 41);
const Color onTapColor = Colors.black;

class MiniGame extends StatefulWidget {
  final int parentIndex;
  final Color opacity;

  MiniGame({super.key, required this.parentIndex, required this.opacity});

  @override
  State<MiniGame> createState() => MiniGameState();
}

class MiniGameState extends State<MiniGame> {
  List<bool> colorChangeIndicator = List.generate(9, (_) => false);

  onTapColorChange(int index) async {
    previousIndex = index;
    setState(() {
      colorChangeIndicator[index] = true;
    });
  }

  onColorReset() {
    if (mounted)
      setState(() {
        colorChangeIndicator[previousIndex] = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    final gameDetails = Provider.of<GameProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        itemCount: 9,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            resetColor();
            gameDetails.updateBoard(
                widget.parentIndex, index, context, onTapColorChange);
            // tapped cell identify
            resetColor = onColorReset;
          },
          child: TicTacToe(
            bgColor:
                colorChangeIndicator[index] ? onTapColor : Colors.transparent,
            borderColor: widget.opacity,
            borderWidth: borderWidth,
            borderBool: ticTacToeBorder[index],
            child: Center(
              child: Opacity(
                opacity: 1,
                child: Text(
                  context.read<GameProvider>().displayXOList[widget.parentIndex]
                      [index],
                  style: GoogleFonts.fuggles(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: gameDetails.displayXOList[widget.parentIndex]
                                  [index] ==
                              player.symbol
                          ? player.color
                          : opponent.color,
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
