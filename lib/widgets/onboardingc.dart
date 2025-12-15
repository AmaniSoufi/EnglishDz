import 'package:englishdz/screens/home_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingC extends StatelessWidget {
  OnBoardingC({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isLastPage,
  });
  String image;
  String title;
  String subtitle;
  Color color;
  bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, height: 350, width: 350),
            Text(
              title,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(subtitle, style: TextStyle(fontSize: 17, color: Colors.white)),
            SizedBox(height: 20),

            if (isLastPage) ElevatedButtonn(),
          ],
        ),
      ),
    );
  }
}

class ElevatedButtonn extends StatelessWidget {
  const ElevatedButtonn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 255, 210, 177),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        "Get Started",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
