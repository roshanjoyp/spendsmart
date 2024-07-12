import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final logger = getLogger('LocalNotificationService');
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    try {
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );

      tz.initializeTimeZones();
      logger.i('Local notifications initialized');
    } catch (e) {
      logger.e('Error initializing local notifications: $e');
    }
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle iOS local notification received
    logger.i(
        'Received local notification: id=$id, title=$title, body=$body, payload=$payload');
  }

  Future<void> requestNotificationPermission() async {
    try {
      final androidImplementation = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
        logger.i('Notification permission requested');
      } else {
        logger.w('Android implementation not available');
      }
    } catch (e) {
      logger.e('Error requesting notification permission: $e');
    }
  }

  Future<void> scheduleDailyNotification(TimeOfDay time) async {
    try {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Daily Expense Reminder',
        'Don\'t forget to add your daily expenses!',
        //_nextInstanceOfTime(time),
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'daily_notification_channel_id',
              'Daily Notifications',
              channelDescription: 'Daily expense reminder notifications',
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(
              categoryIdentifier: 'plainCategory',
            )),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      logger.i('Scheduled daily notification at ${time.hour}:${time.minute}');
    } catch (e) {
      logger.e('Error scheduling daily notification: $e');
    }
  }

  Future<void> showANotification() async {
    try {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker');
      const DarwinNotificationDetails iosNotificationDetails =
          DarwinNotificationDetails(
        categoryIdentifier: 'plainCategory',
      );

      const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: iosNotificationDetails);

      await _flutterLocalNotificationsPlugin.show(
          0, 'plain title', 'plain body', notificationDetails,
          payload: 'item x');
      logger.i('Notification shown: plain title, plain body');
    } catch (e) {
      logger.e('Error showing notification: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await _flutterLocalNotificationsPlugin.cancelAll();
      logger.i('All notifications canceled');
    } catch (e) {
      logger.e('Error canceling all notifications: $e');
    }
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
