import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Icon> scoreKeeper = const [];

  List<Question> questions = [
    Question(
      text: 'You can lead a cow down stairs but not up stairs.',
      correctAnswer: true,
    ),
    Question(
      text: 'Approximately one quarter of human bones are in the feet.',
      correctAnswer: false,
    ),
    Question(
      text: 'A slug\'s blood is green.',
      correctAnswer: false,
    ),
  ];

  int questionNumber = 0;

  answerQuestion(bool answer) {
    final question = questions[questionNumber];
    final answerIsCorrect = question.answerQuestion(answer);

    setState(() {
      if (questionNumber < questions.length - 1) {
        questionNumber++;
      }

      if (scoreKeeper.length < questions.length) {
        scoreKeeper = [
          ...scoreKeeper,
          Icon(
            answerIsCorrect ? Icons.check : Icons.close,
            color: answerIsCorrect ? Colors.green : Colors.red,
          ),
        ];
      }
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
                questions[questionNumber].text,
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
            onPressed: () => answerQuestion(true),
            backgroundColor: Colors.green,
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: 'False',
            onPressed: () => answerQuestion(false),
            backgroundColor: Colors.red,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
