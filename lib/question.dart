class Question {
  Question({
    required this.text,
    required this.correctAnswer,
  });

  final String text;
  final bool correctAnswer;

  answerQuestion(bool answer) => answer == correctAnswer;
}
