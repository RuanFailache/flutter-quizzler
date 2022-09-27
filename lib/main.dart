import 'package:flutter/material.dart';

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

  List<String> questions = const [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
  ];

  int questionNumber = 0;

  answerQuestion(bool answer) {
    final lastQuestionIndex = questions.length - 1;
    setState(() {
      if (questionNumber < lastQuestionIndex) {
        questionNumber++;
      }

      if (scoreKeeper.length < questions.length) {
        scoreKeeper = [
          ...scoreKeeper,
          Icon(
            answer ? Icons.check : Icons.close,
            color: answer ? Colors.green : Colors.red,
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
                questions[questionNumber],
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
