import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:passwordmanager/auth/auth_service.dart';
import 'package:passwordmanager/widgets/my_password.dart';

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
          title: Text('Error',
           style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
          ),
          content: Text('Please enter all fields.',
           style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK',
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

    if (password != confirmPassword) {
      // Show an error message if password and confirm password do not match
      // You can customize this message as needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error',
           style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
          ),
          content: Text('Passwords do not match.',
           style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK',
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
      // Set loading state to true
      isLoading = true;
    });

    // Call the register API
    final authService = AuthService();
    try {
      final success = await authService.register(email, password);

      if (success) {
        // Navigate to the home page if registration succeeds
        Get.offAllNamed('/home');
      } else {
        // Show an error message if registration failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error',
             style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
            ),
            content: Text('Registration failed. Please try again.',
             style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK',
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
    } catch (e) {
      // Show an error message if an error occurred during registration
      // You can customize this message as needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error',
           style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
          ),
          content: Text('An error occurred. Please try again.',
           style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK',
               style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
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
            SvgPicture.asset(
              'assets/lock.svg',
              color: Theme.of(context).colorScheme.onTertiary,
              height: 100,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Lets get started!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
              ),
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
              height: 25,
            ),
            MyButton(text: 'Sign up', onTap: register),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
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
                      fontFamily: 'OpenSans',
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
                    'Logging in...',
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
