class Question {
  final int id, answer_index;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer_index,
      required this.options});
}

const List sample_data = [
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
  {
    "id": 6,
    "question": "5 x 2 = ?",
    "options": ['7', '8', '9', '10'],
    "answer_index": 3,
  },
  {
    "id": 7,
    "question": "18 - 9 = ?",
    "options": ['6', '7', '8', '9'],
    "answer_index": 1
  },
  {
    "id": 8,
    "question": "15 ÷ 5 = ?",
    "options": ['2', '3', '4', '5'],
    "answer_index": 3
  },
  {
    "id": 9,
    "question": "7 + 4 = ?",
    "options": ['9', '10', '11', '12'],
    "answer_index": 2
  },
  {
    "id": 10,
    "question": "10 - 2 = ?",
    "options": ['6', '7', '8', '9'],
    "answer_index": 0
  },
  {
    "id": 11,
    "question": "6 x 3 = ?",
    "options": ['15', '16', '17', '18'],
    "answer_index": 3
  },
  {
    "id": 12,
    "question": "14 + 5 = ?",
    "options": ['17', '18', '19', '20'],
    "answer_index": 2
  },
  {
    "id": 13,
    "question": "20 ÷ 4 = ?",
    "options": ['3', '4', '5', '6'],
    "answer_index": 1
  },
  {
    "id": 14,
    "question": "8 - 5 = ?",
    "options": ['2', '3', '4', '5'],
    "answer_index": 1
  },
  {
    "id": 15,
    "question": "9 x 2 = ?",
    "options": ['15', '16', '17', '18'],
    "answer_index": 3
  }
];
