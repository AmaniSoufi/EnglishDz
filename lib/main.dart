import 'package:englishdz/screens/home_screen.dart';
import 'package:englishdz/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EnglishDz());
}

class EnglishDz extends StatelessWidget {
  const EnglishDz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: OnboardingScreen(),
    );
  }
}
