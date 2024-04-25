import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
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
          MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: true),
          const SizedBox(
            height: 25,
          ),
          MyButton(text: 'Sign up', onTap: () {}),
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
    );
  }
}
