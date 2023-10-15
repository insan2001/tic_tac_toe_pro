import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/emailTextField.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/passwordTextField.dart';
import 'package:tic_tac_toe_pro/custom_widgets/authScreen/titileText.dart';
import 'package:tic_tac_toe_pro/main.dart';
import 'package:tic_tac_toe_pro/screens/authentication/authentication.dart';
import 'package:tic_tac_toe_pro/screens/authentication/forgot.dart';
import 'package:tic_tac_toe_pro/values/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                    height: 300,
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
                        Spacer(flex: 2),
                        Container(
                          child: Column(
                            children: [
                              Text("Sign in with"),
                              IconButton(
                                onPressed: () {
                                  signInWithGoogle();
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: progress
                        ? CircularProgressIndicator(color: Colors.white)
                        : Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: state ? signIn : signUp,
                              child: Text(
                                state ? "Sign in" : "Sign up",
                                style: signUpStyle,
                              ),
                            ),
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

  Future signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final signInAuth = await googleSignInAccount.authentication;
        final credentials = GoogleAuthProvider.credential(
          idToken: signInAuth.idToken,
          accessToken: signInAuth.accessToken,
        );
        await auth.signInWithCredential(credentials);
      }
    } on PlatformException catch (e) {
      print("error");
      scafKey.currentState?.showSnackBar(SnackBar(content: Text(e.code)));
    } catch (e) {
      print("Error");
    }
  }

  Future signIn() async {
    try {
      setState(() {
        progress = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailControl.text.trim(),
          password: passwordControl.text.trim());
    } on FirebaseAuthException catch (e) {
      scafKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.message ?? "")));
      setState(() {
        progress = false;
      });
    }
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  Future signUp() async {
    try {
      setState(() {
        progress = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailControl.text.trim(),
        password: passwordControl.text.trim(),
      );
      scafKey.currentState?.showSnackBar(
          SnackBar(content: Text("${emailControl.text.trim()} was created")));
    } on FirebaseAuthException catch (e) {
      print(e);
      scafKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.message ?? "")));
      setState(() {
        progress = false;
      });
    }
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}
