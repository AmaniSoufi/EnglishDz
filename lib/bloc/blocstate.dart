import '../models/question_model.dart';

abstract class QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int currentIndex;
  final Map<int, String> selectedAnswers;

  QuizLoaded({
    required this.questions,
    required this.currentIndex,
    required this.selectedAnswers,
  });

  QuizLoaded copyWith({
    List<Question>? questions,
    int? currentIndex,
    Map<int, String>? selectedAnswers,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }
}
