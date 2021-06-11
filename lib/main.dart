import 'package:chat_app_new/theme.dart';
import 'package:chat_app_new/views/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
        home:
        SignInScreen(),
        //SignInScreen(),


        //SplashScreen1(),
        // We use routeName so that we dont need to remember the name
        // initialRoute: SplashScreen.routeName,
        // routes: routes,

    );
  }
}