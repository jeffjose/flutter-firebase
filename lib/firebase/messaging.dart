import 'package:firebase_messaging/firebase_messaging.dart';

import './../notifications/index.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

messagingListener() {
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("-----------------------------");
      print("onMessage: $message");
      print("-----------------------------");
    },
    onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("-----------------------------");
      print("onLaunch: $message");
      print("-----------------------------");
    },
    onResume: (Map<String, dynamic> message) async {
      print("-----------------------------");
      print("onResume: $message");
      print("-----------------------------");
    },
  );

  _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true));
  _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });

  _firebaseMessaging.getToken().then((String token) {
    assert(token != null);
    print("Messaging token: $token");
  });
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print(message.toString());
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print("myBackgroundMessageHandler: data $data");
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print("myBackgroundMessageHandler: notification $notification");
  }

  // Or do other work.
}
