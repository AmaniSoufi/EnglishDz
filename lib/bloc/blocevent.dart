abstract class QuizEvent {}

class LoadQuestions extends QuizEvent {
  final String level;
  LoadQuestions(this.level);
}

class SelectAnswer extends QuizEvent {
  final int index;
  final String answer;
  SelectAnswer(this.index, this.answer);
}

class NextCard extends QuizEvent {}
