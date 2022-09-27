import 'package:quizzler/shared/data/quiz.dart';

final _quizData = QuizData();

class QuizController {
  int _questionNumber = 0;

  get totalOfQuestions => _quizData.questions.length;

  get currentQuestionText => _quizData.questions[_questionNumber].text;

  get currentCorrectAnswer =>
      _quizData.questions[_questionNumber].correctAnswer;

  void goToNextQuestion() {
    if (_questionNumber < _quizData.questions.length - 1) {
      _questionNumber++;
    }
  }

  void restart() {
    _questionNumber = 0;
  }
}
