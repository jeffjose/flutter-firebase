import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_state/stream_state.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_firebase/home.dart';
import 'package:flutter_firebase/firebase/firebase.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStreamStatePersist();
  //await Firebase.initializeApp();
  final Future<FirebaseApp> _app = Firebase.initializeApp();

  Stream.fromFuture(_app).listen((app) {
    authListener();
    collectionListener();
  });

  await _app;

  runApp(App());
}

class App extends StatelessWidget {
  MaterialApp withMaterialApp(Widget body, BuildContext context) {
    final ThemeData themeData = ThemeData(
      brightness: Brightness.dark,
      //textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
    );

    return MaterialApp(
      title: 'Flutter Firebase',
      theme: themeData,
      home: Scaffold(
        body: body,
      ),
      debugShowCheckedModeBanner: false,
    );
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
