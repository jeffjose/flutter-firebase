# flutter-firebase starter template

- [x] Flutter
- [x] [Firebase Auth](https://firebase.google.com/docs/auth) with [rxjs](https://pub.dev/packages/rxdart)
- [x] [Firestore](https://firebase.google.com/docs/firestore) with [rxjs](https://pub.dev/packages/rxdart)
- [x] [stream_state](https://pub.dev/packages/stream_state)

## Setup native splash screen and launcher icons

```
# For splash screen (config in pubspec.yaml)
flutter pub pub run flutter_native_splash:create

# For launcher icons (config in pubspec.yaml)
flutter pub run flutter_launcher_icons:main
```

## Notes

1. Run `yarn icons` and `yarn splash`
2. Copy `logo.png` to `android/../drawable`

## Acknowledgements

- Flutter Notifications based on https://github.com/brains-and-beards/flutter-reminders-app
