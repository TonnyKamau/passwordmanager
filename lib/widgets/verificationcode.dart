// create a verification code input

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 310,
        child: PinCodeTextField(
          cursorColor: Theme.of(context).colorScheme.onTertiary,
          cursorWidth: 1,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          appContext: context,
          controller: widget.controller,
          length: 6,
          obscureText:
              false, // Initially set to true for obscuring with asterisks
          animationType: AnimationType.fade,
          textStyle: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onTertiary,
            fontFamily: 'Lato',
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8), // Adjust the border radius
            fieldHeight: 40, // Adjust the field height
            fieldWidth: 40, // Adjust the field width
            activeColor: Theme.of(context).colorScheme.onPrimary,
            inactiveColor: Theme.of(context).colorScheme.onTertiary,
            selectedColor: Theme.of(context).colorScheme.onTertiary,
            selectedFillColor: Theme.of(context).colorScheme.surface,
            disabledColor: Theme.of(context).colorScheme.primary,
            inactiveFillColor: Colors.transparent,
            activeFillColor: Theme.of(context).colorScheme.surface,
            // Set the inactive fill color to transparent
            borderWidth: 2,
            activeBorderWidth: 2,
            inactiveBorderWidth: 2,
            disabledBorderWidth: 2,
            selectedBorderWidth: 2,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          onCompleted: (v) {},
          onChanged: (value) {},
          beforeTextPaste: (String? text) {
            return true; // Prevent pasting text into the field
          },
          hintCharacter: '*',
          obscuringCharacter: '*',
// Hint text for the entire field
        ));
  }
}
