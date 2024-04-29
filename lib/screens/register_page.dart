import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:passwordmanager/auth/auth_service.dart';

import '../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false; // Track loading state
  //Register funtion
  Future<void> register() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
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

    if (password != confirmPassword) {
      // Show an error message if password and confirm password do not match
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
            'Passwords do not match.',
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
      // Set loading state to true
      isLoading = true;
    });

    // Call the register API
    final authService = AuthService();
    try {
      final success = await authService.register(email, password);

      if (success) {
        // Navigate to the home page if registration succeeds
        Get.offAllNamed('/email-verification');
      } else {
        // Show an error message if registration failed
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
              'Registration failed. Please try again.',
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
      // Show an error message if an error occurred during registration
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
            'An error occurred. Please try again.',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(alignment: Alignment.center, children: [
        Column(
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
                  'Lets get started!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false),
            const SizedBox(
              height: 10,
            ),
            MyPassword(
              controller: passwordController,
              hintText: 'Password',
            ),
            const SizedBox(
              height: 10,
            ),
            MyPassword(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
            ),
            const SizedBox(
              height: 15,
            ),
            MyButton(text: 'Sign up', onTap: register),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/');
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        // Loading widget
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
                    'Creating account...',
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
