import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_state/stream_state.dart';

import 'home.dart';
import 'firebase/firebase.dart';

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

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 1,
        navigateAfterSeconds: Home(),
        title: Text(
          'Flutter Firebase!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.network(
            'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/google/241/smiling-face-with-sunglasses_1f60e.png'),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.white);
  }
}
