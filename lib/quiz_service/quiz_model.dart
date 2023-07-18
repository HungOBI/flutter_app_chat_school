class QuizModel {
  String question;
  List<String> option;
  int answerIndex;
  String id;

  QuizModel(
      {required this.question,
      required this.option,
      required this.answerIndex,
      required this.id});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      question: json['question'],
      option: List<String>.from(json['option']),
      answerIndex: json['answerIndex'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['option'] = option;
    data['answerIndex'] = answerIndex;
    data['id'] = id;
    return data;
  }
}
