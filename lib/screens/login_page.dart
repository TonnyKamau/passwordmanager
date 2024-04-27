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
              fontFamily: 'Lato',
            ),
          ),
          content: Text(
            'Please enter both email and password.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Lato',
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

      if (success) {
        // Navigate to the home page if login succeeds
        Get.offAllNamed('/home');
      } else {
        // Show an error message if login failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Login Failed',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            content: Text(
              'Invalid email or password. Please try again.',
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
      setState(() {
        isLoading = false; // Set loading state to false after login attempt
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyLogo(),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Password Manager',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
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
              MyButton(text: 'Sign in', onTap: login),
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
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/register');
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              //forgot password
              GestureDetector(
                onTap: () {
                  Get.toNamed('/forgot-password');
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
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
                        fontFamily: 'Lato',
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
