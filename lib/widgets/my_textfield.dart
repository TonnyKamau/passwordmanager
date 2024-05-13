import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          validator: validator,
          cursorColor: Theme.of(context).colorScheme.onTertiary,
          cursorWidth: 1,
          controller: controller,
          obscureText: obscureText,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: 'Lato',
              fontSize: 14,
            ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onTertiary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15)),
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
