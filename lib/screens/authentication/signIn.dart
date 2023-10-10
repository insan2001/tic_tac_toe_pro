import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/main.dart';
import 'package:tic_tac_toe_pro/screens/authentication/forgot.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickSignUp;
  const SignInScreen({super.key, required this.onClickSignUp});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
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
              TextButton(onPressed: signIn, child: Text("Sign In")),
              GestureDetector(
                child: Text(
                  "Forgot Password",
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPassword(),
                  ));
                },
              ),
              RichText(
                text: TextSpan(
                    text: "No account? ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickSignUp,
                          text: "Sign Up",
                          style: TextStyle(color: Colors.amber))
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailControl.text.trim(),
          password: passwordControl.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      scafKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.message ?? "")));
    }
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}
