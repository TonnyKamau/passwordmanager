import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      return;
    }

    setState(() {
      isLoading = true; // Set loading state to true
    });

    // Call the login API
    final authService = AuthService();
    final success = await authService.login(email, password);

    setState(() {
      isLoading = false; // Set loading state to false after login attempt
    });

    if (success) {
      // get replace paths
      Get.offAllNamed('/home');
    } else {
      // Show an error message if login failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
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
              SvgPicture.asset(
                'assets/lock.svg',
                color: Theme.of(context).colorScheme.onTertiary,
                height: 100,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Password Manager',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontSize: 16,
                  fontFamily: 'OpenSans',
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
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(text: 'Sign in', onTap: login),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
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
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.onPrimary,
              ),
            ),
        ],
      ),
    );
  }
}
