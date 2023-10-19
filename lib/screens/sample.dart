import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage("assets/profile.jpg"),
    );
  }
}
