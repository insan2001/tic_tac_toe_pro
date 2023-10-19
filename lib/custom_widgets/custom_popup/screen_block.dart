import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<bool?> processPopup(_context) async => showDialog<bool>(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SpinKitWanderingCubes(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.blue,
                  ),
                );
              },
            ));
      },
    );
