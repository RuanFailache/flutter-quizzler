import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quizzler/modules/quiz/controller.dart';
import 'package:quizzler/shared/components/button.dart';
import 'package:quizzler/shared/components/page_template.dart';

final _quizController = QuizController();

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  createState() => _QuizPageState();
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

    if (scoreKeeper.length == _quizController.totalOfQuestions) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Congratulations!',
        text: 'You completed the quiz.',
        titleColor: Colors.white,
        textColor: Colors.white,
        confirmBtnColor: Colors.green,
        backgroundColor: Colors.grey.shade900,
      ).whenComplete(() {
        setState(() {
          scoreKeeper = [];
          _quizController.restart();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          scoreKeeper.isEmpty
              ? const Text(
                  'Answer a question to appear here the results',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: scoreKeeper,
                ),
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
