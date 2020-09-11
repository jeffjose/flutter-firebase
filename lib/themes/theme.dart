import 'package:flutter/material.dart';
import 'package:flutter_firebase/stores/store.dart';
import 'package:google_fonts/google_fonts.dart';

// Dark Mode
Color darkbodyColor = Colors.white;
Color darkbackgroundColor = Color(0xff2E2E2E);
Color darkAppBarColor = Colors.white;
Color darkAppBarBackgroundColor = Color(0xff2E2E2E);

// Light Mode
Color lightbodyColor = Colors.black;
Color lightbackgroundColor = Colors.white;
Color lightAppBarColor = Colors.black;
Color lightAppBarBackgroundColor = Colors.white;

ThemeData getDarkModeTheme(BuildContext context) {
  // Dark Mode Theme
  return ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        )),
  );
}

ThemeData getLightModeTheme(BuildContext context) {
  // Light/Normal Mode Theme
  return ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
        )),
  );
}

void themeListener() {
  store.darkMode.stream.listen((event) {
    print(event);

    if (event == true) {
      store.theme.state = AppTheme(
          appBarBackgroundColor: darkAppBarBackgroundColor,
          appBarColor: darkAppBarColor,
          bodyColor: darkbodyColor,
          backgroundColor: darkbackgroundColor);
    } else {
      store.theme.state = AppTheme(
          appBarBackgroundColor: lightAppBarBackgroundColor,
          appBarColor: lightAppBarColor,
          bodyColor: lightbodyColor,
          backgroundColor: lightbackgroundColor);
    }
  });
}
