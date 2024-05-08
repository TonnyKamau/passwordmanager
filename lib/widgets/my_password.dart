import 'package:flutter/material.dart';

class MyPassword extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String Function(String?)? validator;

  const MyPassword({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  _MyPasswordState createState() => _MyPasswordState();
}

class _MyPasswordState extends State<MyPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          cursorColor: Theme.of(context).colorScheme.onTertiary,
          validator: widget.validator,
          cursorWidth: 1,
          controller: widget.controller,
          obscureText: _obscureText,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: 'Lato',
              fontSize: 14,
            ),
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
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
