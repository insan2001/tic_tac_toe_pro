import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/emailTextField.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/passwordTextField.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/titileText.dart';
import 'package:tic_tac_toe_pro/functions/authentication.dart';
import 'package:tic_tac_toe_pro/screens/authentication/forgot.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  bool state = false;
  bool progress = false;

  changeSignIn() {
    setState(() {
      state = !state;
    });
  }

  @override
  void initState() {
    super.initState();
    File(profileLoc).create();
    File(profileLoc2).create();
  }

  @override
  void dispose() {
    emailControl.dispose();
    passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: blackAndWhitegredientBG),
            child: Stack(
              children: [
                Align(
                  child: TitleText(),
                  alignment: Alignment.topCenter,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 380,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(flex: 2),
                        EmailTextField(controller: emailControl),
                        Spacer(flex: 2),
                        PasswordTextField(controller: passwordControl),
                        Spacer(flex: 2),
                        RichText(
                          text: TextSpan(
                              text: state
                                  ? "Dont have an account? "
                                  : "Have an account? ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = state ? forgot : null,
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = changeSignIn,
                                  text: state ? "Sign up" : "Sign in",
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 255, 127, 7),
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ]),
                        ),
                        Spacer(flex: 1),
                        state
                            ? GestureDetector(
                                onTap: () {
                                  forgot();
                                },
                                child: Text(
                                  "Forgot password",
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 255, 127, 7),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            : Text(""),
                        Spacer(flex: 1),
                        SizedBox(
                          height: 140,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () => signInWithGoogle(context),
                                  child: Image.asset("assets/google.png")),
                              progress
                                  ? CircularProgressIndicator(
                                      color: Colors.white)
                                  : Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          if (state) {
                                            signIn(context, emailControl,
                                                passwordControl);
                                          } else {
                                            signUp(context, emailControl,
                                                passwordControl);
                                          }
                                        },
                                        child: Text(
                                          state ? "Sign in" : "Sign up",
                                          style: authButtonStyle,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
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

  forgot() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ForgotPassword(),
    ));
  }
}
