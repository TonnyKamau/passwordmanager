import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: 50, // Adjust the height as needed
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 25), // Adjust padding
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
