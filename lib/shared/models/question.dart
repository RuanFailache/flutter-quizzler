class Question {
  Question({
    required String text,
    required bool correctAnswer,
  })
      : _text = text,
        _correctAnswer = correctAnswer;

  final String _text;
  final bool _correctAnswer;

  get text => _text;

  get correctAnswer => _correctAnswer;
}
