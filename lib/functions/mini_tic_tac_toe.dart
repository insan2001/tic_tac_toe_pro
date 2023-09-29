import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/constants/constants.dart';

class MiniTicTacToe extends StatefulWidget {
  final Player player;
  final Function refresh;
  final Function timeOut;
  final int index;
  final bool won;

  MiniTicTacToe({
    super.key,
    required this.player,
    required this.refresh,
    required this.timeOut,
    required this.index,
    required this.won,
  });

  @override
  State<MiniTicTacToe> createState() => MiniTicTacToeState();
}

class MiniTicTacToeState extends State<MiniTicTacToe> {
  // set the states
  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];
  Timer? timer;
  late int index;
  // late AnimationController _controller;
  // late Animation<double> _animation;
  List<bool> animeValue = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<bool> colorChange = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  Future<bool> change() => Future.delayed(
        Duration(seconds: colorFade),
        () => false,
      );

  gesterTap(int index) async {
    setState(() {
      colorChange[index] = true;
    });
    bool value = await change();
    if (this.mounted) {
      setState(() {
        colorChange[index] = value;
      });
    }
  }

  stateSetter(int index, String symbol) {
    setState(() {
      displayXO[index] = symbol;
    });
    widget.refresh(index, displayXO, widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (displayXO[index] == "")
                    stateSetter(index, widget.player.symbol);
                  gesterTap(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: miniTicTacToeFrame,
                    ),
                    color: colorChange[index] ? changeColor : miniTicTacToeFill,
                  ),
                  child: Center(
                    child: Text(
                      displayXO[index],
                      style: minisymbolStyle,
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
