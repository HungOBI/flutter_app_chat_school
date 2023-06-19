// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_screen.dart';
import 'controllers/question_controller.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
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
                "${_qnController.numOfCorrectAns * 10}/${_qnController.questions.length * 10}",
                style: const TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/');
                  // var i = 0;
                  // Navigator.of(context).popUntil((pre) {
                  //   i++;
                  //   return i > 1;
                  // });
                },
                child: const Text('Answer Again'),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Get.offAll(const HomeScreen());
                  },
                  child: const Text('Out Home Screen')),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
