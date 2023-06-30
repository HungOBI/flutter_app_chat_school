// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app_chat/controllers/question_controller.dart';
import 'package:app_chat/screen/quiz/progress_bar.dart';
import 'package:app_chat/screen/quiz/question_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//const int initialTime = 10;

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  void refreshQuiz() {
    QuestionController questionController = Get.find<QuestionController>();
    questionController.resetQuiz();
    //  questionController.update();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    QuestionController _questionController = Get.put(QuestionController());
    return GetMaterialApp(
      // routes: {
      //   '/': (context) => QuizScreen(),
      // },
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(40, 85, 174, 1)),
      home: WillPopScope(
        onWillPop: () async {
          refreshQuiz();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(40, 85, 174, 1),
            title: const Text(
              'Play Quiz',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () {
                  _questionController.nextQuestion();
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ProgressBar(),
              ),
              const SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => Text.rich(
                      TextSpan(
                        text: 'Question ${_questionController.questionNumber}',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ' /5',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1.5,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _questionController.pageController,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    question: _questionController.questions[index],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
