import 'package:app_chat/controllers/quiz_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'quiz_service.g.dart';

@RestApi(
    baseUrl: "https://64a7b26edca581464b849977.mockapi.io/api/quiz/question")
abstract class QuizService {
  factory QuizService(Dio dio) = _QuizService;

  @GET("/quiz")
  Future<List<QuizModel>> getQuizData();
}
