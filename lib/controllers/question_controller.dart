import 'package:app_chat/quiz_service/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../quiz_service/quiz_model.dart';

final questionControllerProvider = ChangeNotifierProvider<QuestionController>(
  create: (ref) => QuestionController(),
);

class QuestionController extends ChangeNotifier {
  PageController? _pageController;
  PageController? get pageController => _pageController;
  bool _isAnimationStopped = false;
  bool get isAnimationStopped => _isAnimationStopped;
  List<QuizModel> _questions = [];
  List<QuizModel> get questions => _questions;

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
    _pageController?.dispose();
    super.dispose();
  }

  Future<void> fetchQuestions() async {
    _pageController = PageController();
    try {
      final dio = Dio();
      final quizService = QuizService(dio);
      _questions = await quizService.getQuizData();
      print('object: $_questions');
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

  void resetQuiz() {
    _questionNumber = 1;
    _numOfCorrectAns = 0;
    _pageController!.jumpToPage(0);
    notifyListeners();
  }

  void updateTheQnNum(int index) {
    _questionNumber = index + 1;
    notifyListeners();
  }

  void checkAns(QuizModel question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answerIndex;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    }

    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber != _questions.length) {
      _isAnswered = false;
      _pageController!
          .nextPage(duration: Duration(milliseconds: 50), curve: Curves.ease);
    } else {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ScoreScreen()),
      // );
    }
    notifyListeners();
  }
}
