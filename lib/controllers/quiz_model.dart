class QuizModel {
  String question;
  List<String> options;
  int answerIndex;

  QuizModel({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      answerIndex: json['answerIndex'] ?? 0,
    );
  }
}
