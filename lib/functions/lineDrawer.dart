import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/constants/constants.dart';

class Line extends StatefulWidget {
  final int drawPosition;
  Line({super.key, required this.drawPosition});
  @override
  State<StatefulWidget> createState() => _LineState();
}

class _LineState extends State<Line> with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    var controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: LinePainter(_progress, widget.drawPosition));
  }
}

class LinePainter extends CustomPainter {
  late Paint _paint;
  double _progress;
  int drawPosition;

  LinePainter(this._progress, this.drawPosition) {
    _paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 8.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<List<double>> offSet = Position(size.width, size.height, drawPosition);
    // this control which shouldnt drawen according to position
    double drawWidth = offSet[4][0] == 0 ? 1 : _progress;
    double drawHeight = offSet[4][1] == 0 ? 1 : _progress;

    // adjustment on width, size
    double adjustStartWidth = offSet[0][1] == 0
        ? -adjustValue
        : offSet[0][1] == 2
            ? adjustValue
            : 0;
    double adjustStartHeight = offSet[1][1] == 0
        ? -adjustValue
        : offSet[0][1] == 2
            ? adjustValue
            : 0;
    double adjustEndWidth = offSet[2][1] == 0
        ? -adjustValue
        : offSet[0][1] == 2
            ? adjustValue
            : 0;
    double adjustEndHeight = offSet[3][1] == 0
        ? -adjustValue
        : offSet[0][1] == 2
            ? adjustValue
            : 0;

    canvas.drawLine(
        Offset(
            offSet[0][0] + adjustStartWidth, offSet[1][0] + adjustStartHeight),
        Offset(offSet[2][0] * drawWidth + adjustEndWidth,
            offSet[3][0] * drawHeight + adjustEndHeight),
        _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}

List<List<double>> Position(double width, double height, int drawPosition) {
  // [[start width, adjust], [start height, adjust], [end width, adjust], [end height, adjust], [draw horizondal, draw vertical]]
  // 0-adjust in negetive, 1- no need to adjust, 2 - adjust in positive
  // vertical Lines
  List<List<double>> TopLeftBottomLeft = [
    [0, 2],
    [0, 2],
    [0, 2],
    [height, 0],
    [0, 1]
  ];
  List<List<double>> TopCenterBottomCenter = [
    [width / 2, 1],
    [0, 2],
    [width / 2, 1],
    [height, 0],
    [0, 1]
  ];
  List<List<double>> TopRightBottomRight = [
    [width, 0],
    [0, 2],
    [width, 0],
    [height, 0],
    [0, 1]
  ];
  // horizondal lines
  List<List<double>> TopLeftTopRight = [
    [0, 2],
    [0, 2],
    [width, 0],
    [0, 2],
    [1, 0]
  ];
  List<List<double>> LeftCenterRigtCenter = [
    [0, 2],
    [height / 2, 1],
    [width, 0],
    [height / 2, 1],
    [1, 0]
  ];
  List<List<double>> BottomLeftBottomRight = [
    [0, 2],
    [height, 0],
    [width, 0],
    [height, 0],
    [1, 0]
  ];
  // diagnol
  List<List<double>> TopLeftBottomRight = [
    [0, 2],
    [0, 2],
    [width, 0],
    [height, 0],
    [1, 1]
  ];
  List<List<double>> BottomLeftTopRight = [
    [0, 2],
    [height, 0],
    [width, 0],
    [0, 2],
    [1, 1]
  ];

  if (drawPosition == 17) {
    return TopLeftBottomLeft;
  } else if (drawPosition == 28) {
    return TopCenterBottomCenter;
  } else if (drawPosition == 39) {
    return TopRightBottomRight;
  } else if (drawPosition == 13) {
    return TopLeftTopRight;
  } else if (drawPosition == 46) {
    return LeftCenterRigtCenter;
  } else if (drawPosition == 79) {
    return BottomLeftBottomRight;
  } else if (drawPosition == 19) {
    return TopLeftBottomRight;
  } else {
    return BottomLeftTopRight;
  }
}
