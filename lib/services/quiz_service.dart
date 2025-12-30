import 'package:quiz_backend_client/quiz_backend_client.dart';
import 'package:englishdz/models/question_model.dart' as frontend;

/// Service to handle quiz operations with the backend
class QuizService {
  final Client client;

  QuizService(this.client);

  /// Convert backend Question to frontend Question model
  frontend.Question _convertToFrontendQuestion(Question backendQuestion) {
    return frontend.Question(
      question: backendQuestion.questionText,
      answers: [
        backendQuestion.option1,
        backendQuestion.option2,
        backendQuestion.option3,
        backendQuestion.option4,
      ],
      correct: backendQuestion.correctAnswer,
    );
  }

  /// Get all questions for a specific level
  Future<List<frontend.Question>> getQuestionsByLevel(String level) async {
    try {
      final backendQuestions = await client.questions.getByLevel(level);
      return backendQuestions
          .map((q) => _convertToFrontendQuestion(q))
          .toList();
    } catch (e) {
      throw Exception('Failed to load questions: $e');
    }
  }

  /// Get all questions
  Future<List<frontend.Question>> getAllQuestions() async {
    try {
      final backendQuestions = await client.questions.getAll();
      return backendQuestions
          .map((q) => _convertToFrontendQuestion(q))
          .toList();
    } catch (e) {
      throw Exception('Failed to load questions: $e');
    }
  }
}
