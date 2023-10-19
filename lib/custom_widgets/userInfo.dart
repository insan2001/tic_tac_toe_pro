import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_pro/custom_widgets/custom_popup/name_change.dart';
import 'package:tic_tac_toe_pro/providers/user_detail.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

class UserInfoDisplay extends StatefulWidget {
  const UserInfoDisplay({super.key});

  @override
  State<UserInfoDisplay> createState() => _UserInfoDisplayState();
}

class _UserInfoDisplayState extends State<UserInfoDisplay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              SizedBox(width: 20),
              Flexible(flex: 1, child: Text("User name :", style: userInfo)),
              SizedBox(width: 20),
              Flexible(
                flex: 2,
                child: Text(
                  context.watch<UserProvider>().userName,
                  style: userInfo,
                ),
              ),
            ],
          ),
        ),
        Positioned(
            right: 0,
            child: IconButton(
                onPressed: () {
                  nameChangePopup(context);
                },
                icon: Icon(Icons.edit)))
      ],
    );
  }
}
