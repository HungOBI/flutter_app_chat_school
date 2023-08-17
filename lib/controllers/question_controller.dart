import 'package:app_chat/quiz_service/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../quiz_service/quiz_model.dart';
import '../screen/quiz/score_screen.dart';

final questionControllerProvider = ChangeNotifierProvider(
  create: (ref) => QuestionController(),
);

class QuestionController extends ChangeNotifier {
  PageController? _pageController;
  PageController? get pageController => _pageController;
  late bool _isAnimationStopped = false;
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

  bool _quizEnded = false;
  bool get quizEnded => _quizEnded;
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
    furtherQuestion();
    notifyListeners();
  }

  void furtherQuestion() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_questionNumber != _questions.length) {
        _pageController!.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      } else {
        _quizEnded = true;
      }
      _isAnswered = false;
      notifyListeners();
    });
  }

  void nextQuestion(BuildContext context) {
    if (_questionNumber != _questions.length) {
      _pageController!.nextPage(
          duration: const Duration(milliseconds: 50), curve: Curves.ease);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ScoreScreen()),
      );
    }
    notifyListeners();
  }
}