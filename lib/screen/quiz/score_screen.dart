// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_screen.dart';
import 'controllers/question_controller.dart';

class ScoreScreen extends StatelessWidget {
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
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    // Get.to(const HomeScreen());
                    var i = 0;
                    Navigator.of(context).popUntil((pre) {
                      i++;
                      return i > 1;
                    });
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
