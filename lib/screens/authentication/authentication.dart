import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_pro/screens/authentication/signIn.dart';
import 'package:tic_tac_toe_pro/screens/authentication/signUp.dart';
import 'package:tic_tac_toe_pro/screens/home.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => AuthenticationState();
}

class AuthenticationState extends State<Authentication> {
  bool isLogin = false;

  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return isLogin
                ? SignInScreen(onClickSignUp: toggle)
                : SignUpScreen(onClickSignUp: toggle);
          }
        });
  }
}
