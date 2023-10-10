import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final emailControl = TextEditingController();

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Receive an email to reset your password."),
          TextFormField(
            decoration: InputDecoration(label: Text("Email")),
            controller: emailControl,
            textInputAction: TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && EmailValidator.validate(email)
                    ? null
                    : "Enter a valid email",
          ),
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: emailControl.text.trim());
              },
              child: Text("Reset Password")),
        ],
      ),
    );
  }
}
