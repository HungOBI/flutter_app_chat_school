// ignore_for_file: unused_field
import 'package:app_chat/notifi_service/local_notifi_service.dart';
import 'package:app_chat/screen/auth/login_screen.dart';
import 'package:app_chat/screen/auth/splash_screen.dart';
import 'package:app_chat/screen/home/home_screen.dart';
import 'package:app_chat/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializeNotification();
  await NotificationService().showMatchingNotifications();

  // NotificationService().showNotification(1, 'Hi Guys', 'I am obi');

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

  runApp(const MyApp());
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
