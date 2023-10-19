import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordTextField({super.key, required this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassord = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.blue,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: TextField(
              obscureText: showPassord,
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Your password",
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassord = !showPassord;
                      });
                    },
                    icon: Icon(
                        showPassord ? Icons.visibility : Icons.visibility_off)),
                labelText: "Password",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
