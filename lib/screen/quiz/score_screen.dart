import 'package:app_chat/controllers/question_controller.dart';
import 'package:app_chat/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questionController = Provider.of<QuestionController>(context);
    final score = questionController.numOfCorrectAns;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Score',
              style: TextStyle(
                  fontSize: 24, color: Color.fromARGB(255, 204, 250, 0)),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              '$score',
              style: const TextStyle(
                  fontSize: 100, color: Color.fromARGB(255, 204, 250, 0)),
            ),
            const SizedBox(
              height: 250,
            ),
            ElevatedButton(
              onPressed: () {
                questionController.resetQuiz();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                );
              },
              child: const Text('Back Home'),
            ),
          ],
        ),
      ),
    );
  }
}