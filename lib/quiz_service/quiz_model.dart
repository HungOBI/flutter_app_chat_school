class QuizList {
  late List<QuizModel> quizList;

  QuizList({required this.quizList});

  factory QuizList.fromJson(List<dynamic> json) {
    List<QuizModel> quizList =
        json.map((item) => QuizModel.fromJson(item)).toList();
    return QuizList(quizList: quizList);
  }
}

class QuizModel {
  String? question;
  List<String>? option;
  int? answerIndex;
  String? id;

  QuizModel({this.question, this.option, this.answerIndex, this.id});

  QuizModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    option = List<String>.from(json['option']);
    answerIndex = json['answerIndex'];
    id = json['id'];
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
