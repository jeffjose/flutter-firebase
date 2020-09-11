import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_state/stream_state.dart';
import 'package:flutter/services.dart';

import 'package:flutter_firebase/home.dart';
import 'package:flutter_firebase/stores/store.dart';
import 'package:flutter_firebase/firebase/firebase.dart';
import 'package:flutter_firebase/themes/theme.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStreamStatePersist();
  //await Firebase.initializeApp();
  final Future<FirebaseApp> _app = Firebase.initializeApp();

  Stream.fromFuture(_app).listen((app) {
    authListener();
    collectionListener();
    themeListener();
  });

  await _app;

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  MaterialApp withMaterialApp(Widget body, BuildContext context) {
    ThemeData lightModeTheme = getLightModeTheme(context);
    ThemeData darkModeTheme = getDarkModeTheme(context);

    return MaterialApp(
      title: 'Flutter Firebase',
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      themeMode: store.darkMode.state ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: body,
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void initState() {
    super.initState();

    // Setup a listener to update UI on theme switch
    store.darkMode.stream.listen((event) {
      // Force update
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xff2E2E2E),
        systemNavigationBarColor: Color(0xff2E2E2E)));

    return withMaterialApp(Center(child: Home()), context);
  }
}
