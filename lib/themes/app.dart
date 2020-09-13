import 'package:flutter/material.dart';
import 'package:flutter_firebase/stores/store.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

// Note: If you're changing this, ensure the native splash_screen is updated as well
// pubspec.yaml (which writes to colors.xml)
Color darkPrimary = materialColor;
Color darkPrimaryLight = materialColorLight;
Color darkPrimaryLighter = materialColorLighter;
Color darkPrimaryLightest = materialColorLightest;
Color darkPrimaryDark = materialColorDark;
Color darkAccent = materialAccent;

ThemeData getDarkModeTheme(BuildContext context) {
  // Dark Mode Theme
  return ThemeData(
    brightness: Brightness.dark,
    // Primary Colors
    primaryColor: darkPrimary,
    primaryColorLight: darkPrimaryLight,
    primaryColorDark: darkPrimaryDark,
    primaryColorBrightness: Brightness.dark,
    // Accent Colors
    accentColor: Colors.white,
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: darkPrimaryLight, // Lighter version of dark
    canvasColor: darkPrimary,
    //cardColor: Color(0xaaF5E0C3),
    //dividerColor: Color(0x1f6D42CE),
    //focusColor: Color(0x1aF5E0C3),
    textTheme: GoogleFonts.interTextTheme(
      Theme.of(context).textTheme.copyWith(
            headline1: TextStyle(color: Colors.blue),
            headline2: TextStyle(color: Colors.blue),
            headline3: TextStyle(color: Colors.blue),
            headline4: TextStyle(color: Colors.blue),
            headline5: TextStyle(color: Colors.orange),
            headline6: TextStyle(color: Colors.white), // App Bar
            subtitle1: TextStyle(color: Colors.blue),
            subtitle2: TextStyle(color: Colors.blue),
            bodyText1: TextStyle(color: darkPrimaryLightest), // Settings Item
            bodyText2: TextStyle(color: darkPrimaryLightest), // Vanilla text
            caption:
                TextStyle(color: darkPrimaryLightest), // Settings Item Header
            button: TextStyle(color: Colors.red),
            overline: TextStyle(color: Colors.red),
          ),
    ),
    buttonColor: darkPrimaryLighter,
    iconTheme: Theme.of(context).iconTheme.copyWith(color: darkPrimaryLightest),
  );
}

ThemeData getLightModeTheme(BuildContext context) {
  // Light/Normal Mode Theme
  return ThemeData(
    brightness: Brightness.light,
    // Primary Colors
    primaryColor: Colors.white,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.white,
    primaryColorBrightness: Brightness.light,
    // Accent Colors
    accentColor: darkPrimary,
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    //cardColor: Color(0xaaF5E0C3),
    //dividerColor: Color(0x1f6D42CE),
    //focusColor: Color(0x1aF5E0C3),
    textTheme: GoogleFonts.interTextTheme(
      Theme.of(context).textTheme.copyWith(
            headline1: TextStyle(color: Colors.blue),
            headline2: TextStyle(color: Colors.blue),
            headline3: TextStyle(color: Colors.blue),
            headline4: TextStyle(color: Colors.blue),
            headline5: TextStyle(color: Colors.orange),
            headline6: TextStyle(color: Colors.black), // App Bar
            subtitle1: TextStyle(color: Colors.blue),
            subtitle2: TextStyle(color: Colors.blue),
            bodyText1: TextStyle(color: Colors.black87), // Settings Item
            bodyText2: TextStyle(color: Colors.black), // Vanilla text
            caption: TextStyle(color: Colors.black87), // Settings Item Header
            button: TextStyle(color: Colors.red),
            overline: TextStyle(color: Colors.red),
          ),
    ),
    // TODO
    buttonColor: Colors.grey,
    // TODO
    iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black54),
  );
}

void themeListener() {
  store.darkMode.stream.listen((darkMode) {
    store.theme.state = darkMode ? darkModeTheme : lightModeTheme;
  });
}

AppTheme darkModeTheme = AppTheme(
  appBarBackgroundColor: darkPrimary,
  //appBarColor: darkAppBarColor,
  //bodyColor: darkbodyColor,
  //backgroundColor: darkbackgroundColor,
);

AppTheme lightModeTheme = AppTheme(
  appBarBackgroundColor: Colors.white,
  //appBarColor: lightAppBarColor,
  //bodyColor: lightbodyColor,
  //backgroundColor: lightbackgroundColor,
);
