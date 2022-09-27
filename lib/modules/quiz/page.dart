import 'package:flutter/material.dart';
import 'package:quizzler/modules/quiz/controller.dart';
import 'package:quizzler/shared/components/button.dart';

final _quizController = QuizController();

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = const [];

  checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = _quizController.currentCorrectAnswer;
    final isAnswerCorrect = correctAnswer == userPickedAnswer;

    setState(() {
      if (scoreKeeper.length < _quizController.totalOfQuestions) {
        scoreKeeper = [
          ...scoreKeeper,
          Icon(
            isAnswerCorrect ? Icons.check : Icons.close,
            color: isAnswerCorrect ? Colors.green : Colors.red,
          ),
        ];
      }
      _quizController.goToNextQuestion();
    });
  }

  buildHeader() {
    if (scoreKeeper.isEmpty) {
      return const Text(
        'Answer a question to appear here the results',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: scoreKeeper,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(),
          Expanded(
            child: Center(
              child: Text(
                _quizController.currentQuestionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          CustomButton(
            text: 'True',
            onPressed: () => checkAnswer(true),
            backgroundColor: Colors.green,
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: 'False',
            onPressed: () => checkAnswer(false),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
