import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final Color borderColor;
  final List<bool> borderBool;
  final Color bgColor;

  const TicTacToe({
    super.key,
    required this.child,
    required this.borderColor,
    required this.borderWidth,
    required this.borderBool,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: borderBool[0]
              ? BorderSide(
                  color: borderColor,
                  width: borderWidth,
                )
              : BorderSide.none,
          top: borderBool[1]
              ? BorderSide(
                  color: borderColor,
                  width: borderWidth,
                )
              : BorderSide.none,
          right: borderBool[2]
              ? BorderSide(
                  color: borderColor,
                  width: borderWidth,
                )
              : BorderSide.none,
          bottom: borderBool[3]
              ? BorderSide(
                  color: borderColor,
                  width: borderWidth,
                )
              : BorderSide.none,
        ),
        color: bgColor,
      ),
      child: child,
    );
  }
}
