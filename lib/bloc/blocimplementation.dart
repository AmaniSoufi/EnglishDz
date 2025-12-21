import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/question_model.dart';
import 'blocevent.dart';
import 'blocstate.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizLoading()) {
    on<LoadQuestions>((event, emit) {
      // 1. Load your questions (hardcoded or from backend later)
      final questions = <Question>[
        Question(
          question: "She ___ to school every day.",
          answers: ["go", "goes", "going", "gone"],
          correct: "goes",
        ),
        Question(
          question: "She ___ to school every day.",
          answers: ["go", "goes", "going", "gone"],
          correct: "goes",
        ),
        Question(
          question: "She ___ to school every day.",
          answers: ["go", "goes", "going", "gone"],
          correct: "goes",
        ),
        Question(
          question: "She ___ to school every day.",
          answers: ["go", "goes", "going", "gone"],
          correct: "goes",
        ),
        Question(
          question: "They ___ playing football now.",
          answers: ["is", "are", "am", "be"],
          correct: "are",
        ),
        Question(
          question: "They ___ playing football now.",
          answers: ["is", "are", "am", "be"],
          correct: "are",
        ),
        Question(
          question: "They ___ playing football now.",
          answers: ["is", "are", "am", "be"],
          correct: "are",
        ),
        Question(
          question: "They ___ playing football now.",
          answers: ["is", "are", "am", "be"],
          correct: "are",
        ),
        Question(
          question: "I am waiting ___ the bus stop.",
          answers: ["in", "at", "on", "to"],
          correct: "at",
        ),
        Question(
          question: "I am waiting ___ the bus stop.",
          answers: ["in", "at", "on", "to"],
          correct: "at",
        ),
        // add all questions...
      ];

      emit(
        QuizLoaded(questions: questions, currentIndex: 0, selectedAnswers: {}),
      );
    });

    on<SelectAnswer>((event, emit) {
      if (state is QuizLoaded) {
        final currentState = state as QuizLoaded;
        final selected = Map<int, String>.from(currentState.selectedAnswers);

        // Only allow selecting once per question
        if (!selected.containsKey(event.index)) {
          selected[event.index] = event.answer;

          int nextIndex = currentState.currentIndex;
          // Only increase currentIndex if the selected answer is correct
          if (event.answer == currentState.questions[event.index].correct) {
            nextIndex++;
          }

          emit(
            currentState.copyWith(
              selectedAnswers: selected,
              currentIndex: nextIndex > currentState.questions.length
                  ? currentState.questions.length
                  : nextIndex,
            ),
          );
        }
      }
    });
  }
}
