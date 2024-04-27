// create a verification code input
import 'package:flutter/cupertino.dart';
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
        width: MediaQuery.of(context).size.width * 0.43,
        child: PinCodeTextField(
          cursorColor: Theme.of(context).colorScheme.onTertiary,
          cursorWidth: 1,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          appContext: context,
          controller: widget.controller,
          length: 6,
          obscureText:
              true, // Initially set to true for obscuring with asterisks
          animationType: AnimationType.fade,
          textStyle: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onTertiary,
            fontFamily: 'OpenSans',
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8), // Adjust the border radius
            fieldHeight: 50, // Adjust the field height
            fieldWidth: 50, // Adjust the field width
            activeColor: Theme.of(context).colorScheme.onTertiary,
            inactiveColor: Theme.of(context).colorScheme.onTertiary,
            selectedColor: Theme.of(context).colorScheme.onTertiary,
            selectedFillColor: Theme.of(context).colorScheme.background,
            disabledColor: Theme.of(context).colorScheme.primary,
            inactiveFillColor: Colors.transparent,
            activeFillColor: Theme.of(context).colorScheme.background,
            // Set the inactive fill color to transparent
            borderWidth: 1,
            activeBorderWidth: 1,
            inactiveBorderWidth: 1,
            disabledBorderWidth: 1,
            selectedBorderWidth: 1,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          onCompleted: (v) {
            print('Completed');
          },
          onChanged: (value) {
            debugPrint(value);
          },
          beforeTextPaste: (String? text) {
            return true; // Prevent pasting text into the field
          },
          hintCharacter: '*',
          obscuringCharacter: '*',
// Hint text for the entire field
        ));
  }
}
