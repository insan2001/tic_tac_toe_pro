import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/emailTextField.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/titileText.dart';
import 'package:tic_tac_toe_pro/functions/authentication.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

final emailControl = TextEditingController();

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: blackAndWhitegredientBG),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 48,
                        ))),
                Align(
                  alignment: Alignment.topCenter,
                  child: TitleText(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 300,
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          "Receive an email to reset your password.",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Spacer(),
                        EmailTextField(controller: emailControl),
                        Spacer(),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                              onPressed: () {
                                forgotPassword(context, emailControl);
                              },
                              child: Text(
                                "Reset Password",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
