import 'package:app_chat/quiz_service/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../quiz_service/quiz_model.dart';

final questionControllerProvider = ChangeNotifierProvider(
  create: (ref) => QuestionController(),
);

class QuestionController extends ChangeNotifier {
  PageController? _pageController;
  PageController? get pageController => _pageController;

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
    // _animationController.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void OnInit() {
    // _animationController = AnimationController(
    //   duration: const Duration(seconds: 10),
    //   vsync: this,
    // );
    // _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
    //   ..addListener(() {
    //     notifyListeners();
    //   });

    // _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
  }

  Future<void> fetchQuestions() async {
    try {
      final dio = Dio();
      final quizService = QuizService(dio);
      final response = await quizService.getQuizData();
      _questions = response
          .map((json) => QuizModel.fromJson(json as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

  void resetQuiz() {
    _questionNumber = 1;
    _numOfCorrectAns = 0;
    // _animationController.reset();
    // _animationController.forward().whenComplete(nextQuestion);
    notifyListeners();
  }

  // void nextQuestion() {
  //   if (_questionNumber != _questions.length) {
  //     _isAnswered = false;
  // _animationController.reset();
  // _animationController.forward().whenComplete(nextQuestion);
  //   } else {
  // Go to score screen
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => ScoreScreen()),
  // );
  //   }
  //   notifyListeners();
  // }

  void updateTheQnNum(int index) {
    _questionNumber = index + 1;
    notifyListeners();
  }

  void checkAns(QuizModel question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answerIndex!;
    _selectedAns = selectedIndex;
    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    }
    // _animationController.stop();
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () {
      // nextQuestion();
    });
  }
}
