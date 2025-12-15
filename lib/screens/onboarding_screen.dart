import 'package:englishdz/widgets/onboardingc.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe_upgrade/Helpers/Helpers.dart';
import 'package:liquid_swipe_upgrade/liquid_swipe.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pages = [
    OnBoardingC(
      image: "images/on3.png",
      title: 'Choose Your Level ',
      subtitle: 'Start with the level that fits your English skills',
      color: const Color.fromARGB(255, 255, 210, 177),
      isLastPage: false,
    ),
    OnBoardingC(
      image: "images/on1.png",
      title: 'Answer Fun Quizzes',
      subtitle: 'Test your grammar and with quick questions',
      color: const Color.fromARGB(255, 255, 238, 168),
      isLastPage: false,
    ),
    OnBoardingC(
      image: "images/on2.png",
      title: 'Level Up Your English',
      subtitle: 'Pass quizzes and improve step by step',
      color: Color.fromARGB(255, 255, 217, 217),
      isLastPage: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: true,
        slideIconWidget: const Icon(Icons.arrow_back_ios, color: Colors.white),
        waveType: WaveType.liquidReveal,
      ),
    );
  }
}
