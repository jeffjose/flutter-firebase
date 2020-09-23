<p>
  <a href="#">
    <img alt="A starter template for flutter-firebase" src="https://raw.github.com/jeffjose/flutter-firebase/master/banner.png">
  </a>
</p>

# flutter-firebase starter template

- [x] Flutter
- [x] [Firebase Auth](https://firebase.google.com/docs/auth) with [rxjs](https://pub.dev/packages/rxdart)
- [x] [Firestore](https://firebase.google.com/docs/firestore) with [rxjs](https://pub.dev/packages/rxdart)
- [x] [Firebase Messaging](https://firebase.google.com/docs/cloud-messaging) with [rxjs](https://pub.dev/packages/rxdart)
- [x] [Firebase Functions](https://firebase.google.com/docs/functions)
- [x] [Local notifications](https://pub.dev/packages/flutter_local_notifications)
- [x] [stream_state](https://pub.dev/packages/stream_state)

## Setup native splash screen and launcher icons

```
# For splash screen (config in pubspec.yaml)
flutter pub pub run flutter_native_splash:create

# For launcher icons (config in pubspec.yaml)
flutter pub run flutter_launcher_icons:main
```

## Notes

1. Rename folder in `src/main/{java,kotlin}/com.example/flutter_firebase` to `src/main/{java,kotlin}/YOUR_PACKAGE_NAME`
2. Run `yarn icons` and `yarn splash`
3. Copy `logo.png` to `android/../drawable`
4. Change package name `com.example.flutter-firebase` in `android/..`
5. To test FCM messaging, install `fcm-cli`, and get the FCM `TOKEN` from `flutter logs` after the app loads, and `SERVER_KEY` from **Settings > Cloud Messaging**
   ```
   fcm send --server-key SERVER_KEY --to TOKEN --notification.title title --notification.body "`date`" --notification.click_action "FLUTTER_NOTIFICATION_CLICK"
   ```

## Acknowledgements

- Flutter Notifications based on https://github.com/brains-and-beards/flutter-reminders-app
