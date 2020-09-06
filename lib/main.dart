import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_firebase/home.dart';
import 'package:flutter_firebase/controllers/bindings/auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      home: IntroScreen(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });

      if (_currentUser != null) {
        //_handleGetContact()
      }
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
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
