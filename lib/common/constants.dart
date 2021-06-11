import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);
//
// final headingStyle = TextStyle(
//   fontSize: MediaQuery.of(context).size.width * ,
//   fontWeight: FontWeight.bold,
//   color: Colors.black,
//   height: 1.5,
// );

const defaultDuration = Duration(milliseconds: 250);

class Constants {
  //static const kPrimaryColor = Color(0xFFFF7643);
  static const int SPLASH_SCREEN_TIME = 2;
  static int processIndex = 0;
  static String appname = "Flutter App";
  static DateFormat commondateFormate = DateFormat("yyyy-MM-dd hh:mm:ss");
  static DateFormat ymdFormate = DateFormat("yyyy-MM-dd");
  static DateFormat dmytFormate = DateFormat("dd-MM-yyyy hh:mm:ss");
  static DateFormat dmyt1Formate = DateFormat("dd/MM/yyyy hh:mm:ss");
  static DateFormat dmythmFormate = DateFormat("dd-MM-yyyy hh:mm");
  static DateFormat dmythm1Formate = DateFormat("dd/MM/yyyy hh:mm");
  static DateFormat hmsFormate = DateFormat("hh:mm:ss");
  static DateFormat hmFormate = DateFormat("hh:mm");
}

class reqserver {
  static String baseurl = 'https://php2.shaligraminfotech.com/owle/public/api/';
  static String getBase1 = 'php2.shaligraminfotech.com';
  static String getBase2 = '/owle/public/api/';
  static String imgbaseurl = 'http://guard-my-vote.s3.us-east-2.amazonaws.com/';

  static String loginUrl = 'auth/login';
  static String forgotpwdUrl = 'auth/forgot-password';
  static String getCMSpageUrl = 'get-cms-page-links';
  static String logoutUrl = 'auth/logout';
  static String getSurveyCountUrl = 'get-survey-count';
  static String getSurveyListUrl = 'get-survey-list';
  static String getSurveyQuestionUrl = 'get-survey-questions';
}

class CustomColors {
  static final Color firebaseNavy = Color(0xFF2C384A);
  static final Color firebaseOrange = Color(0xFFF57C00);
  static final Color firebaseAmber = Color(0xFFFFA000);
  static final Color firebaseYellow = Color(0xFFFFCA28);
  static final Color firebaseGrey = Color(0xFFECEFF1);
  static final Color googleBackground = Color(0xFF4285F4);
}

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

class validationMsg {
  static String emailNotEnter = 'Enter email';
  static String noInternet = 'Please connect to the internet to continue.';
}
