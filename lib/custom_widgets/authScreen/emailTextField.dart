import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  const EmailTextField({super.key, required this.controller});

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
            child: TextFormField(
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && EmailValidator.validate(email)
                      ? null
                      : "       Enter a valid email",
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Your email address",
                prefixIcon: Icon(
                  Icons.email_outlined,
                ),
                labelText: "Email address",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
