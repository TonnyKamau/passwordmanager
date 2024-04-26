import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPassword extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyPassword(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // Adjust the value as needed
          border: Border.all(
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
        child: TextField(
          cursorColor: Theme.of(context).colorScheme.onTertiary,
          cursorWidth: 1,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: 'OpenSans',
            ),
            border: InputBorder.none, // Hide the default border
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, // Adjust the padding as needed
              vertical: 15, // Adjust the padding as needed
            ),
          ),
        ),
      ),
    );
  }
}
