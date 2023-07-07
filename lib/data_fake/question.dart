class Question {
  final int id;
  final String question;
  final List<String> options;
  final int answerIndex;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.answerIndex,
  });
}

final sample_data = [
  {
    "id": 1,
    "question": "1 + 5 = ?",
    "options": ['7', '10', '6', '5'],
    "answer_index": 2,
  },
  {
    "id": 2,
    "question": "8 x 3 = ?",
    "options": ['22', '24', '25', '27'],
    "answer_index": 1,
  },
  {
    "id": 3,
    "question": "12 - 7 = ?",
    "options": ['4', '5', '6', '7'],
    "answer_index": 1,
  },
  {
    "id": 4,
    "question": "16 ÷ 4 = ?",
    "options": ['2', '4', '6', '8'],
    "answer_index": 1,
  },
  {
    "id": 5,
    "question": "9 + 3 = ?",
    "options": ['10', '11', '12', '13'],
    "answer_index": 2,
  },
];
