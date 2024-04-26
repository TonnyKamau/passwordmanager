import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyPassword extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const MyPassword({
    Key? key,
    required this.controller,
    required this.hintText,
   
  }) : super(key: key);

  @override
  _MyPasswordState createState() => _MyPasswordState();
}

class _MyPasswordState extends State<MyPassword> {
  bool _obscureText =true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // Adjust the value as needed
          border: Border.all(
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
        child: TextFormField(
          cursorColor: Theme.of(context).colorScheme.onTertiary,
          cursorWidth: 1,
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: 'OpenSans',
            ),
            border: InputBorder.none, // Hide the default border
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, // Adjust the padding as needed
              vertical: 15, // Adjust the padding as needed
            ),
            suffixIcon: IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
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
