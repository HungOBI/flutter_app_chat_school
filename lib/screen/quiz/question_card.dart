import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/question_controller.dart';
import '../../controllers/quiz_model.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final QuizModel question;

  @override
  Widget build(BuildContext context) {
    final questionController = Provider.of<QuestionController>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ...List.generate(
            question.options.length,
            (index) => Option(
              text: question.options[index],
              index: index,
              press: () {
                // questionController.checkAns(question, index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
