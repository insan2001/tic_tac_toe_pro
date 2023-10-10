import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/main.dart';
import 'package:tic_tac_toe_pro/screens/authentication/authentication.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickSignUp;
  const SignUpScreen({super.key, required this.onClickSignUp});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  @override
  void dispose() {
    emailControl.dispose();
    passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              Text("Welcome to the game"),
              TextField(
                controller: emailControl,
                decoration: InputDecoration(
                    labelText: "Email", suffix: Icon(Icons.email)),
              ),
              TextField(
                controller: passwordControl,
                decoration: InputDecoration(
                    labelText: "Password",
                    suffix: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye),
                    )),
              ),
              TextButton(onPressed: signUp, child: Text("Sign Up")),
              RichText(
                text: TextSpan(
                    text: "Have an account? ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickSignUp,
                          text: "Sign In",
                          style: TextStyle(color: Colors.amber))
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailControl.text.trim(),
        password: passwordControl.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      scafKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.message ?? "")));
    }
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}
