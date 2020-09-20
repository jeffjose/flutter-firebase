import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import 'package:meta/meta.dart';

class ReminderNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReminderNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

final FlutterLocalNotificationsPlugin Notifications =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReminderNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReminderNotification>();

final BehaviorSubject<String> notifications = BehaviorSubject<String>();

Future<void> initNotifications() async {
  NotificationAppLaunchDetails notificationAppLaunchDetails =
      await Notifications.getNotificationAppLaunchDetails();

  var androidConfig = AndroidInitializationSettings('logo');
  var iOSConfig = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReminderNotification(
            id: id, title: title, body: body, payload: payload));
      });

  var initializationSettings = InitializationSettings(androidConfig, iOSConfig);

  await Notifications.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      print('Incoming notification payload: $payload');
    }
    notifications.add(payload);
  });

  _requestIOSPermissions();
}

void _requestIOSPermissions() {
  Notifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> showNotification(String title, String body) async {
  var androidConfig = AndroidNotificationDetails(
      '0', 'flutter-firebase-channel', 'flutter-firebae-channel description',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSConfig = IOSNotificationDetails();

  var details = NotificationDetails(androidConfig, iOSConfig);

  await Notifications.show(0, title, body, details,
      payload: 'payload-coming-from-notification');
}

Future<void> turnOffAllNotifications() async {
  await Notifications.cancelAll();
}

Future<void> turnOffNotificationById(num id) async {
  await Notifications.cancel(id);
}

Future<void> scheduleNotification(
    String id, String body, DateTime datetime) async {
  var androidConfig = AndroidNotificationDetails(
    id,
    'Reminder notifications',
    'Remember about it',
    icon: 'logo',
  );
  var iOSConfig = IOSNotificationDetails();
  var details = NotificationDetails(androidConfig, iOSConfig);
  await Notifications.schedule(0, 'Reminder', body, datetime, details);
}

Future<void> scheduleNotificationPeriodically(
    String id, String body, RepeatInterval interval) async {
  var androidConfig = AndroidNotificationDetails(
    id,
    'Reminder notifications',
    'Remember about it',
    icon: 'smile_icon',
  );
  var iOSConfig = IOSNotificationDetails();
  var details = NotificationDetails(androidConfig, iOSConfig);
  await Notifications.periodicallyShow(0, 'Reminder', body, interval, details);
}
