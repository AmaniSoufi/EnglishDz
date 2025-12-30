import 'package:card_stack_swiper/card_stack_swiper.dart';
import 'package:englishdz/bloc/blocevent.dart';
import 'package:englishdz/bloc/blocimplementation.dart';
import 'package:englishdz/bloc/blocstate.dart';
import 'package:englishdz/colors/colors.dart';
import 'package:englishdz/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizScreen extends StatelessWidget {
  final String level;
  QuizScreen({super.key, required this.level});

  final CardStackSwiperController _controller = CardStackSwiperController();
  final List<Color> cardColors = [primaryColor, secondaryColor, thirdColor];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc()..add(LoadQuestions(level)),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 251, 226),
        appBar: AppBar(
          iconTheme: IconThemeData(color: primaryColor),
          title: Text(
            "Quiz $level",
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 251, 226),
        ),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuizError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          // Retry loading questions
                          context.read<QuizBloc>().add(LoadQuestions(level));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'إعادة المحاولة',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is QuizLoaded) {
              final questions = state.questions;
              final selected = state.selectedAnswers;
              final index = state.currentIndex;

              // Safety check for empty questions
              if (questions.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد أسئلة متاحة',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // Progress bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: LinearProgressIndicator(
                      value: questions.length > 0 
                          ? (index / questions.length).clamp(0.0, 1.0)
                          : 0.0,
                      color: primaryColor,
                      backgroundColor: Colors.white,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  // Cards - use Expanded to prevent overflow
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 20,
                      ),
                      child: CardStackSwiper(
                        controller: _controller,
                        cardsCount: questions.length,
                        cardBuilder: (context, i, h, v) {
                          final q = questions[i];
                          // Use MediaQuery to get available height for the card
                          final screenHeight = MediaQuery.of(context).size.height;
                          final availableHeight = screenHeight * 0.6; // Use 60% of screen height
                          return _quizCard(context, q, i, selected, availableHeight);
                        },
                        onSwipe: (i, direction, velocity) {
                          // Swipe only moves card visually, progress handled on answer
                          return true;
                        },
                      ),
                    ),
                  ),
                  // Next button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (index < questions.length) {
                          _controller.swipe(CardStackSwiperDirection.right);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Error loading quiz"));
            }
          },
        ),
      ),
    );
  }

  Widget _quizCard(
    BuildContext context,
    Question q,
    int index,
    Map<int, String> selected,
    double? availableHeight,
  ) {
    String? sel = selected[index];
    
    // Use available height if provided, otherwise use a reasonable default
    final cardHeight = availableHeight != null && availableHeight.isFinite
        ? (availableHeight * 0.8).clamp(200.0, 600.0)
        : 400.0;

    return Container(
      height: cardHeight,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColors[index % cardColors.length],
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(color: Colors.white, offset: Offset(0, 6), blurRadius: 10),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              q.question,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ...q.answers.map((ans) {
              Color bgColor = Colors.white;
              Color txtColor = primaryColor;

              if (sel != null) {
                if (ans == q.correct) {
                  bgColor = Colors.green;
                  txtColor = Colors.white;
                } else if (ans == sel && ans != q.correct) {
                  bgColor = Colors.red;
                  txtColor = Colors.white;
                }
              }

              return InkWell(
                onTap: () {
                  context.read<QuizBloc>().add(SelectAnswer(index, ans));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    ans,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: txtColor,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
