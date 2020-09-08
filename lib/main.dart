import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_state/stream_state.dart';

import 'firebase/firebase.dart';
import 'components/IntroScreen.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStreamStatePersist();
  //await Firebase.initializeApp();
  final Future<FirebaseApp> _app = Firebase.initializeApp();

  //_googleSignIn.signInSilently();

  Stream.fromFuture(_app).listen((app) {
    authListener();
    collectionListener();
  });

  runApp(App());
}

class App extends StatelessWidget {
  MaterialApp withMaterialApp(Widget body) {
    return MaterialApp(
        title: 'Flutter Firebase',
        theme: ThemeData.dark(),
        home: Scaffold(
          body: body,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return withMaterialApp(Center(child: IntroScreen()));
  }
}
