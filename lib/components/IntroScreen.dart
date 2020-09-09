import 'package:flutter/material.dart';
import 'package:flutter_firebase/home.dart';
import 'package:splashscreen/splashscreen.dart';

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
      image: Image.asset('assets/images/logo.png'),
      backgroundColor: Color(0xff1A202C),
      photoSize: 100.0,
      loaderColor: Colors.transparent,
    );
  }
}
