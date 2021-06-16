import 'package:flutter/material.dart';

import 'common/constants.dart';


ThemeData theme() {
  return ThemeData(
    primarySwatch: MyColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    //inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

class MyColors {

  static const MaterialColor primaryColor = MaterialColor(
    0XFF6A62B7,
    <int, Color>{
      50: Color(0XFF6A62B7),
      100: Color(0XFF6A62B7),
      200: Color(0XFF6A62B7),
      300: Color(0XFF6A62B7),
      400: Color(0XFF6A62B7),
      500: Color(0XFF6A62B7),
      600: Color(0XFF6A62B7),
      700: Color(0XFF6A62B7),
      800: Color(0XFF6A62B7),
      900: Color(0XFF6A62B7),
    },
  );
}

// InputDecorationTheme inputDecorationTheme() {
//   OutlineInputBorder outlineInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(28),
//     borderSide: BorderSide(color: kTextColor),
//     gapPadding: 10,
//   );
//   return InputDecorationTheme(
//     // If  you are using latest version of flutter then lable text and hint text shown like this
//     // if you r using flutter less then 1.20.* then maybe this is not working properly
//     // if we are define our floatingLabelBehavior in our theme then it's not applayed
//     floatingLabelBehavior: FloatingLabelBehavior.always,
//     contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
//     enabledBorder: outlineInputBorder,
//     focusedBorder: outlineInputBorder,
//     border: outlineInputBorder,
//   );
// }

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    //color: Color(0XFF6A62B7).withOpacity(1.0),
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}
