import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        mouseCursor: WidgetStateProperty.all<MouseCursor>(
          WidgetStateMouseCursor.clickable,
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          Theme.of(context).colorScheme.onTertiary,
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 15,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontFamily: 'Lato',
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
