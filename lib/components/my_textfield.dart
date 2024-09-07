import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obsecureText;

  const MyTextfield(
      {super.key,
      required this.labelText,
      required this.obsecureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        label: Text(labelText),
      ),
      obscureText: obsecureText,
    );
  }
}
