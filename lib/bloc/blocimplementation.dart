import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/app_config.dart';
import '../services/quiz_service.dart';
import 'blocevent.dart';
import 'blocstate.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizService _quizService = QuizService(quizClient);

  QuizBloc() : super(QuizLoading()) {
    on<LoadQuestions>(_onLoadQuestions);

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

  /// Load questions from backend for the specified level
  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<QuizState> emit,
  ) async {
    emit(QuizLoading());

    try {
      // Log the level being requested for debugging
      print('Loading questions for level: "${event.level}"');
      
      // Load questions from backend
      final questions = await _quizService.getQuestionsByLevel(event.level);
      
      print('Loaded ${questions.length} questions for level: "${event.level}"');

      if (questions.isEmpty) {
        emit(QuizError(
          'لا توجد أسئلة متاحة للمستوى "${event.level}".\n'
          'يرجى التحقق من أن المستوى موجود في قاعدة البيانات.'
        ));
        return;
      }

      emit(QuizLoaded(
        questions: questions,
        currentIndex: 0,
        selectedAnswers: {},
      ));
    } catch (e) {
      // Log the error for debugging
      print('Error loading questions: $e');
      print('Error type: ${e.runtimeType}');
      
      // Emit error state with detailed message
      String errorMessage = 'فشل في تحميل الأسئلة';
      
      if (e.toString().contains('Connection') || e.toString().contains('Failed host lookup')) {
        errorMessage = 'لا يمكن الاتصال بالخادم.\n'
            'يرجى التحقق من أن الخادم يعمل على: http://localhost:8080';
      } else if (e.toString().contains('404') || e.toString().contains('Not Found')) {
        errorMessage = 'المستوى "${event.level}" غير موجود في قاعدة البيانات.';
      } else {
        errorMessage = 'حدث خطأ أثناء تحميل الأسئلة:\n$e';
      }
      
      emit(QuizError(errorMessage));
    }
  }
}
