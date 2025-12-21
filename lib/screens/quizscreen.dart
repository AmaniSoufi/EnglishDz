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
    final height = MediaQuery.of(context).size.height;

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
            } else if (state is QuizLoaded) {
              final questions = state.questions;
              final selected = state.selectedAnswers;
              final index = state.currentIndex;

              return Column(
                children: [
                  // Progress bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: LinearProgressIndicator(
                      value: index / questions.length,
                      color: primaryColor,
                      backgroundColor: Colors.white,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  // Cards
                  SizedBox(
                    height: height * 0.65,
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
                          return _quizCard(context, q, i, selected);
                        },
                        onSwipe: (i, direction, velocity) {
                          // Swipe only moves card visually, progress handled on answer
                          return true;
                        },
                      ),
                    ),
                  ),
                  // Next button
                  ElevatedButton(
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
  ) {
    String? sel = selected[index];

    return Container(
      height: 100,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColors[index % cardColors.length],
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(color: Colors.white, offset: Offset(0, 6), blurRadius: 10),
        ],
      ),
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
    );
  }
}
