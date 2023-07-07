import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../../controllers/question_controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionController = QuestionController();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const Spacer(),
              const Text(
                "Score",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${questionController.numOfCorrectAns * 10}/${questionController.questions.length * 10}",
                style: const TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  questionController.resetQuiz();
                },
                child: const Text('Answer Again'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: const Text('Go to Home Screen'),
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
