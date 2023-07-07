import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_fake/question.dart';
import '../screen/quiz/score_screen.dart';

final questionControllerProvider = ChangeNotifierProvider<QuestionController>(
  create: (ref) => QuestionController(),
);

class QuestionController extends ChangeNotifier {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Animation<double> get animation => _animation;

  final List<Question> _questions = sample_data
      .map(
        (question) => Question(
          id: question['id'] as int,
          question: question['question'] as String,
          options: List<String>.from((question['options'] as List<dynamic>)
              .map((option) => option.toString())),
          answerIndex: question['answer_index'] as int,
        ),
      )
      .toList();
  late PageController _pageController;
  PageController get pageController => _pageController;

  List<Question> get questions => _questions;
  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAns = 0;
  int get correctAns => _correctAns;

  int _selectedAns = 0;
  int get selectedAns => _selectedAns;

  int _questionNumber = 1;
  int get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void resetQuiz() {
    _questionNumber = 1;
    _numOfCorrectAns = 0;
    _pageController.jumpToPage(0);
    _animationController.reset();
    _animationController.forward().whenComplete(nextQuestion);
    notifyListeners();
  }

  void nextQuestion() {
    if (_questionNumber != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.ease,
      );
      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      //chuyen man
    }
    notifyListeners();
  }

  void updateTheQnNum(int index) {
    _questionNumber = index + 1;
    notifyListeners();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answerIndex;
    _selectedAns = selectedIndex;
    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    }
    _animationController.stop();
    notifyListeners();
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }
}
