import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwordmanager/auth/auth_service.dart';
import 'package:passwordmanager/widgets/widgets.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController verifyController = TextEditingController();
  bool isLoading = false;
  bool isResending = false;
  // function to email verification code
  Future<void> verifyEmail() async {
    final String email = emailController.text.trim();
    final String verificationCode = verifyController.text.trim();

    if (email.isEmpty || verificationCode.isEmpty) {
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
      isLoading = true;
    });
    // Call the resetPassword function from the AuthService class
    // This function will send a password reset email to the user
    // and return a boolean value based on the success of the operation
    final isVerified = await AuthService().verifyEmail(email, verificationCode);
    setState(() {
      isLoading = false;
    });
    if (isVerified) {
      // Show a success message if the password reset email was sent successfully
      // You can customize this message as needed
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
            'Email verified successfully.',
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
      // Show an error message if the password reset email failed to send
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
            'Email verification failed. Please try again.',
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
  }

  // function to resend verification code
  Future<void> resendCode() async {
    final String email = emailController.text.trim();
    if (email.isEmpty) {
      // Show an error message if email is empty
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
            'Please enter your email address.',
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
      isResending = true;
    });
    final isSent = await AuthService().resendCode(email);
    setState(() {
      isResending = false;
    });
    if (isSent == 201) {
      // Show a success message if the password reset email was sent successfully
      // You can customize this message as needed
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
            'Verification code sent successfully.',
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
    } else if (isSent == 400) {
      // Show an error message if the password reset email failed to send
      // You can customize this message as needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Email Not registered',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
            ),
          ),
          content: Text(
            'Please try with a registered email.',
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
    } else {
      // Show an error message if the password reset email failed to send
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
            'Failed to send verification code. Please try again.',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const MyLogo(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'An email will be sent to your email address.',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: emailController,
                hintText: 'Please verify your email address to continue.',
                obscureText: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return '';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              VerificationCode(
                controller: verifyController,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(text: 'Resend Code', onTap: resendCode),
                  const SizedBox(width: 10),
                  MyButton(text: 'Verify Email', onTap: verifyEmail),
                ],
              ),
            ],
          ),
        ),
        // Loading widget
        if (isLoading)
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
                    'Verifying email...',
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
        //is resending
        if (isResending)
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
                    'Resending code...',
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
