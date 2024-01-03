import 'package:flutter/material.dart';

// Text field for Login, Register and forgot password, etc..

class CustomTextfield extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool? obscure;
  final String? errorMessage;

  const CustomTextfield({
    super.key,
    required this.text,
    required this.controller,
    this.obscure,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure == true ? true : false,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        labelText: text,
        errorText: errorMessage,
        hintStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }
}
