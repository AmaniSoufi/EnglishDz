import 'package:englishdz/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
