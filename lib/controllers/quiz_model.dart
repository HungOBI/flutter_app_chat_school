class QuizModel {
  String id;
  String question;
  List<String> options;
  int answerIndex;

  QuizModel({
    required this.id,
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      answerIndex: json['answerIndex'] ?? 0,
    );
  }
}

class QuizList {
  List<QuizModel> quizList;

  QuizList({required this.quizList});

  factory QuizList.fromJson(List<dynamic> json) {
    List<QuizModel> quizList =
        json.map((item) => QuizModel.fromJson(item)).toList();
    return QuizList(quizList: quizList);
  }
}

void printQuizList(QuizList quizList) {
  for (var quiz in quizList.quizList) {
    print('ID: ${quiz.id}');
    print('Question: ${quiz.question}');
    print('Options: ${quiz.options}');
    print('Answer Index: ${quiz.answerIndex}');
    print('---------------------------');
  }
}
