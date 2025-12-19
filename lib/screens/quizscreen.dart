import 'package:card_stack_swiper/card_stack_swiper.dart';
import 'package:englishdz/colors/colors.dart';
import 'package:englishdz/widgets/elevatedbutton.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String level;
  QuizScreen({super.key, required this.level});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "She ___ to school every day.",
      "answers": ["go", "goes", "going", "gone"],
    },
    {
      "question": "I am waiting ___ the bus stop.",
      "answers": ["in", "at", "on", "to"],
    },
    {
      "question": "We live ___ a big house.",
      "answers": ["at", "to", "in", "on"],
    },
    {
      "question": "They usually eat lunch ___ 12 o’clock.",
      "answers": ["in", "at", "on", "to"],
    },
    {
      "question": "The cat is ___ the table.",
      "answers": ["on", "in", "to", "at"],
    },
    {
      "question": "He goes ___ work every morning.",
      "answers": ["to", "in", "at", "on"],
    },
    {
      "question": "She was born ___ May.",
      "answers": ["in", "at", "on", "to"],
    },
    {
      "question": "I often watch TV ___ the evening.",
      "answers": ["at", "in", "on", "to"],
    },
    {
      "question": "We meet ___ the park after school.",
      "answers": ["at", "on", "in", "to"],
    },
    {
      "question": "Do you go ___ holiday ___ summer?",
      "answers": ["to / in", "at / on", "in / to", "on / at"],
    },
  ];

  final List<Color> cardColors = [primaryColor, secondaryColor, thirdColor];

  // 1️⃣ نضيف CardStackController
  final CardStackSwiperController _controller = CardStackSwiperController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final List<Widget> cards = questions.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> q = entry.value;
      Color color = cardColors[index % cardColors.length];
      return _quizCard(q, color);
    }).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 226),
      appBar: AppBar(
        title: Text("Quiz ${widget.level}"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 251, 226),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: height * 0.6,
              child: CardStackSwiper(
                controller: _controller, // 2️⃣ نربط Controller
                cardsCount: cards.length,
                cardBuilder: (context, index, h, v) {
                  return cards[index];
                },
              ),
            ),
          ),
          SizedBox(height: height * 0.05),

          ElevatedButton(
            onPressed: () {
              _controller.swipe(
                CardStackSwiperDirection.right,
              ); // 3️⃣ لما نضغط Next → نعرض البطاقة التالية
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quizCard(Map<String, dynamic> q, Color color) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
        //  border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          // ظل خفيف أسفل البطاقة
          BoxShadow(
            color: Colors.white, // لون الظل
            offset: const Offset(0, 6), // فقط أسفل (y=6)
            blurRadius: 10, // نعومة الظل
            spreadRadius: 0, // انتشار الظل
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            q["question"],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ...q["answers"].map<Widget>((ans) => _answerRow(ans)),
        ],
      ),
    );
  }

  Widget _answerRow(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
      ),
    );
  }
}
