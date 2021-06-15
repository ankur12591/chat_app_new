import 'package:chat_app_new/services/auth.dart';
import 'package:chat_app_new/theme.dart';
import 'package:chat_app_new/views/home.dart';
import 'package:chat_app_new/views/other_chat_app/home.dart';
import 'package:chat_app_new/views/sign_in/sign_in_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: FutureBuilder(
        future: AuthMethods().getCurrentUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return
            //  HomeScreen(currentUserId: '',);
              Home();
          } else {
            return SignInScreen();
            //SignIn();
          }
        },
      ),
    );
  }
}
