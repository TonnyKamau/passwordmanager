import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              fontFamily: 'OpenSans',
            ),
          ),
          content: Text(
            'Please enter all fields.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'OpenSans',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
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
    final isVerified =
        await AuthService().verifyEmail(email, verificationCode);
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
              fontFamily: 'OpenSans',
            ),
          ),
          content: Text(
            'Email verified successfully.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'OpenSans',
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
                  fontFamily: 'OpenSans',
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
              fontFamily: 'OpenSans',
            ),
          ),
          content: Text(
            'Email verification failed. Please try again.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'OpenSans',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
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
      appBar: AppBar(
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
            children: <Widget>[
              SvgPicture.asset(
                'assets/lock.svg',
                color: Theme.of(context).colorScheme.onTertiary,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'An email has been sent to your email address.',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                  controller: emailController,
                  hintText: 'Please verify your email address to continue.',
                  obscureText: false),
              const SizedBox(height: 20),
              VerificationCode(
                controller: verifyController,
              ),
              const SizedBox(height: 10),
              MyButton(text: 'Verify Email', onTap: verifyEmail),
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
                      fontFamily: 'OpenSans',
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
