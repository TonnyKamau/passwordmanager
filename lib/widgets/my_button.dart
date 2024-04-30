import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        mouseCursor: MaterialStateProperty.all<MouseCursor>(
          MaterialStateMouseCursor.clickable,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.onTertiary,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 15,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.background,
          fontFamily: 'Lato',
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
