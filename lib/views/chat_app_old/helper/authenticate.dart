
import 'package:chat_app_new/views/chat_app_old/views/signin.dart';
import 'package:chat_app_new/views/chat_app_old/views/signin1.dart';
import 'package:chat_app_new/views/chat_app_old/views/signin_with_google.dart';
import 'package:chat_app_new/views/chat_app_old/views/signup.dart';
import 'package:flutter/material.dart';

class Authenticate1 extends StatefulWidget {
  @override
  _Authenticate1State createState() => _Authenticate1State();
}

class _Authenticate1State extends State<Authenticate1> {
  bool? showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = showSignIn!;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn!) {
      return SignInGoogle();
    } else {
      return SignUp();
    }
  }
}
