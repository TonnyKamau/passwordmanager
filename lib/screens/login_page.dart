import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:passwordmanager/auth/auth_service.dart';

import '../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false; // Track loading state

  Future<void> login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show an error message if email or password is empty
      // You can customize this message as needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Poppins',
            ),
          ),
          content: Text(
            'Please enter both email and password.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Poppins',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
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
      final success = await authService.login(email, password);

      if (success == 200) {
        // Navigate to the home page if login succeeds
        Get.offAllNamed('/home');
      } else if (success == 400) {
        //Your account needs to be verified to proceed.
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Account not verified',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Poppins',
              ),
            ),
            content: Text(
              'Your account needs to be verified to proceed. Please Click very account.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Poppins',
              ),
            ),
            actions: [
              ElevatedButton(
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
                onPressed: () {
                  Get.toNamed('/email-verification');
                },
                child: Text(
                  'verify account',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        );
      } else if (success == 404) {
        // Show an error message if login failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Not Found',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Poppins',
              ),
            ),
            content: Text(
              'Kindly check on your internet connection.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Poppins',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        // Show an error message if login failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Login Failed',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Poppins',
              ),
            ),
            content: Text(
              'Invalid email or password. Please try again.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Poppins',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontFamily: 'Poppins',
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
              fontFamily: 'Poppins',
            ),
          ),
          content: Text(
            'An error occurred. Please try again later.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Poppins',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Set loading state to false after login attempt
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Form(
            key: _formKey,
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
                      'Password Manager',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return '';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyPassword(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                MyButton(
                  text: 'Sign in',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with submission
                      login();
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/register');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                //forgot password
                TextButton(
                  onPressed: () {
                    Get.toNamed('/forgot-password');
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
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
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
