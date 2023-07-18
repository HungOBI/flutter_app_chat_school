// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, avoid_print

import 'package:app_chat/screen/time_table/dataBaseHelper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initializeNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future<void> showNotification(int id, String title, String body) async {
  //   var dateTime = DateTime(DateTime.now().year, DateTime.now().month,
  //       DateTime.now().day, 14, 47, 0);
  //   tz.initializeTimeZones();
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     tz.TZDateTime.from(dateTime, tz.local),
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(id.toString(), 'Go To Bed',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           icon: '@mipmap/ic_launcher'),
  //     ),
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //   );
  // }

  Future<void> showMatchingNotifications() async {
    List<DateTime> timetable = await DatabaseHelper().getAllDateTime();
    print('timetable: $timetable');

    if (timetable.isEmpty) {
      print('Timetable is empty');
      return;
    }

    for (DateTime dateTime in timetable) {
      await _showNotification(dateTime);
    }
  }

  Future<void> _showNotification(DateTime dateTime) async {
    int notificationId = 1;
    String notificationTitle = "App_School";
    String notificationBody = "You have event";

    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      notificationTitle,
      notificationBody,
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          notificationId.toString(),
          'Go To Bed',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
