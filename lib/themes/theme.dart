import 'package:flutter/material.dart';
import 'package:flutter_firebase/stores/store.dart';
import 'package:google_fonts/google_fonts.dart';

Color darkPrimary = Color(0xff1a202c);
Color darkPrimaryLight = Color(0xff414755);
Color darkPrimaryDark = Color(0xff000000);

ThemeData getDarkModeTheme(BuildContext context) {
  // Dark Mode Theme
  return ThemeData(
    brightness: Brightness.dark,
    // Primary Colors
    primaryColor: darkPrimary,
    primaryColorLight: darkPrimaryLight,
    primaryColorDark: darkPrimaryDark,
    primaryColorBrightness: Brightness.dark,
    ////Accent Colors
    accentColor: Colors.white,
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff2D3748), // Lighter version of dark
    canvasColor: Color(0xff1A202C),
    //cardColor: Color(0xaaF5E0C3),
    //dividerColor: Color(0x1f6D42CE),
    //focusColor: Color(0x1aF5E0C3),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        )),
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
    //Accent Colors
    accentColor: Color(0xff1a202c),
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    //cardColor: Color(0xaaF5E0C3),
    //dividerColor: Color(0x1f6D42CE),
    //focusColor: Color(0x1aF5E0C3),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
        )),
  );
}

void themeListener() {
  store.darkMode.stream.listen((darkMode) {
    store.theme.state = darkMode ? darkModeTheme : lightModeTheme;
  });
}

AppTheme darkModeTheme = AppTheme(
  appBarBackgroundColor: Color(0xff1a202c),
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
