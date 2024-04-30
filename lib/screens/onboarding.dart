
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class PasswordManagerOnboardingScreen extends StatefulWidget {
  const PasswordManagerOnboardingScreen({super.key});

  @override
  _PasswordManagerOnboardingScreenState createState() =>
      _PasswordManagerOnboardingScreenState();
}

class _PasswordManagerOnboardingScreenState
    extends State<PasswordManagerOnboardingScreen> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstTime = prefs.getBool('isFirstTime') ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isFirstTime ? _buildOnboardingScreen() : _redirect();
  }

  Widget _buildOnboardingScreen() {
    return IntroductionScreen(
     pages: [
        PageViewModel(
          title: "Welcome to SecurePass",
          body: "Manage your passwords securely with SecurePass.",
          image: Center(
              child:
                  Image.asset("assets/images/onboarding1.png", height: 175.0)),
        ),
        PageViewModel(
          title: "Strong Encryption",
          body:
              "Your passwords are encrypted using industry-standard algorithms.",
          image: Center(
              child:
                  Image.asset("assets/images/onboarding2.png", height: 175.0)),
        ),
        PageViewModel(
          title: "Easy Access",
          body:
              "Access your passwords from anywhere with our cross-platform support.",
          image: Center(
              child:
                  Image.asset("assets/images/onboarding3.png", height: 175.0)),
        ),
      ],
      onDone: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirstTime', false);
        // Navigate to the main screen or perform any necessary action.
        Get.offAllNamed('/'); // Redirect to home screen
      },
      onSkip: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirstTime', false);
        // Navigate to the main screen or perform any necessary action.
        Get.offAllNamed('/'); // Redirect to home screen
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _redirect() {
    // Redirect to home screen using Get package
    Get.offAllNamed('/');
    return Scaffold(); // Placeholder widget
  }
}
