import 'package:app_chat/controllers/quiz_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/question_controller.dart';
import '../../controllers/quiz_service.dart';
import 'progress_bar.dart';
import 'question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Future<void> initState() async {
    super.initState();
    final questionController = context.read<QuestionController>();
    questionController.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuestionController>(
          create: (_) => QuestionController(),
        ),
      ],
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
        ),
        body: Consumer<QuestionController>(
          builder: (context, questionController, _) {
            return WillPopScope(
              onWillPop: () async {
                questionController.resetQuiz();
                return true;
              },
              child: Container(
                margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // child: ProgressBar(),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Question ${questionController.questionNumber}',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color.fromRGBO(255, 255, 255, 1),
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
                        controller: questionController.pageController,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: questionController.updateTheQnNum,
                        itemCount: questionController.questions.length,
                        itemBuilder: (context, index) {
                          final question = questionController.questions[index];
                          return QuestionCard(question: question);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
