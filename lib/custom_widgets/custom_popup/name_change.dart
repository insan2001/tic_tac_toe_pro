import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/providers/user_detail.dart';

Future<void> nameChangePopup(BuildContext context) async {
  final TextEditingController control = TextEditingController();
  control.text = context.read<UserProvider>().userName;
  final userDetails = Provider.of<UserProvider>(context, listen: false);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Change name'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: control,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Rename'),
            onPressed: () {
              userDetails.changeName(control.text).then((value) =>
                  context.mounted ? Navigator.pop(context, false) : null);
            },
          ),
        ],
      );
    },
  );
}
