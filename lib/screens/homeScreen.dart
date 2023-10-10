import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("${user.displayName}"),
            TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: Text("Sign out"))
          ],
        ),
      ),
    );
  }
}
