import 'package:app_chat/quiz_service/quiz_model.dart';
import 'package:app_chat/quiz_service/quiz_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_chat/controllers/question_controller.dart';
import 'package:app_chat/notifi_service/local_notifi_service.dart';
import 'package:app_chat/screen/auth/login_screen.dart';
import 'package:app_chat/screen/auth/splash_screen.dart';
import 'package:app_chat/screen/home/home_screen.dart';
import 'package:app_chat/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

void main() async {
  final dio = Dio();
  final quizService = QuizService(dio);
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializeNotification();
  await NotificationService().showMatchingNotifications();
  try {
    final quizData = await quizService.getQuizData();
    processQuizList(quizData);
    // Xử lý dữ liệu quizData nhận được từ API ở đây
  } catch (error) {
    // Xử lý lỗi khi gọi API
    print('Error: $error');
  }

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<QuestionController>(
          create: (_) => QuestionController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

void processQuizList(List<dynamic> quizData) {
  final List<QuizModel> questions = quizData
      .map((json) => QuizModel.fromJson(json as Map<String, dynamic>))
      .toList();

  for (var question in questions) {
    print('Question: ${question.question}');
    print('Options: ${question.option}');
    print('Answer Index: ${question.answerIndex}');
    print('ID: ${question.id}');
    print('----------------');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Constants().primaryColor,
          scaffoldBackgroundColor: const Color.fromRGBO(40, 85, 174, 1)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
