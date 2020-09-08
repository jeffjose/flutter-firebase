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
        title: Text(
          'flutter-firebase',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        image: Image.network(
            'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/google/263/hundred-points_1f4af.png'),
        backgroundColor: Colors.black54,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.white);
  }
}
