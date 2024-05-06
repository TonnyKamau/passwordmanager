import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:passwordmanager/auth/auth_service.dart';
import 'package:passwordmanager/widgets/widgets.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordResetController = TextEditingController();
  bool isLoading = false;
  bool isResending = false;
  Future resetPassword() async {
    final String email = emailController.text.trim();
    final String newPassword = passwordController.text.trim();
    final String verificationCode = passwordResetController.text.trim();

    if (email.isEmpty || newPassword.isEmpty || verificationCode.isEmpty) {
      // Show an error message if email or password is empty
      // You can customize this message as needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          content: Text(
            'Please enter all fields.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      isLoading = true; // Set loading state to true
    });

    // Call the login API
    final authService = AuthService();
    try {
      final bool success =
          await authService.resetPassword(email, newPassword, verificationCode);

      if (success) {
        // Show a success message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Success',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            content: Text(
              'Password reset successful.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ],
          ),
        );
        Get.offAllNamed('/');
      } else {
        // Show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            content: Text(
              'An error occurred. Please try again later.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle other errors, such as network errors

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          content: Text(
            'An error occurred. Please try again later.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ],
        ),
      );
    } finally {
      // Set loading state to false
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> resendResetCode() async {
    final String email = emailController.text.trim();
    if (email.isEmpty) {
      // Show an error message if email or password is empty
      // You can customize this message as needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          content: Text(
            'Please enter your email.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      isResending = true; // Set loading state to true
    });

    // Call the login API
    final authService = AuthService();
    try {
      final success = await authService.resendResetCode(email);

      if (success==201) {
        // Show a success message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Success',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            content: Text(
              'Verification code sent to email.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        // Show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            content: Text(
              'An error occurred. Please try again later.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle other errors, such as network errors

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          content: Text(
            'An error occurred. Please try again later.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ],
        ),
      );
    } finally {
      // Set loading state to false
      setState(() {
        isResending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backbutton
        leading: Material(
          color: Colors.transparent,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
            color: Theme.of(context).colorScheme.onTertiary,
            splashColor: Colors.transparent,
            highlightColor: Colors
                .transparent, // Additionally set highlight color to transparent
            hoverColor:
                Colors.transparent, // Set hover color to transparent if needed
          ),
        ),
      ),
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyLogo(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Forgot Password/ Reset Password',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MyTextField(
                  controller: emailController,
                  hintText: 'Email to reset password',
                  obscureText: false),
              const SizedBox(height: 10),
              MyPassword(
                controller: passwordController,
                hintText: 'New Password',
              ),
              const SizedBox(height: 20),
              VerificationCode(
                controller: passwordResetController,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(text: 'Confirm Reset', onTap: resetPassword),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: resendResetCode,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontFamily: 'Lato',
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
        if (isLoading)
          // dialogue with words saying logging in
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'resetting...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(isResending)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'resending...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
          ),
      ]),
    );
  }
}
