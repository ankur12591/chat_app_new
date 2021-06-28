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



// import 'package:chat_app_new/theme.dart';
// import 'package:chat_app_new/views/chat_app_old/helper/authenticate.dart';
// import 'package:chat_app_new/views/chat_app_old/helper/helperfunctions.dart';
// import 'package:chat_app_new/views/chat_app_old/views/chatrooms.dart';
// import 'package:chat_app_new/views/chat_app_old/views/chatrooms1.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//    await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   bool? userIsLoggedIn;
//
//   @override
//   void initState() {
//     getLoggedInState();
//     super.initState();
//   }
//
//   getLoggedInState() async {
//     await HelperFunctions1.getUserLoggedInSharedPreference().then((value){
//       setState(() {
//         userIsLoggedIn  = value!;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FlutterChat',
//       debugShowCheckedModeBanner: false,
//       theme: theme(),
//       // ThemeData(
//       //   primaryColor: Color(0xff145C9E),
//       //   scaffoldBackgroundColor: Color(0xff1F1F1F),
//       //   accentColor: Color(0xff007EF4),
//       //   fontFamily: "OverpassRegular",
//       //   visualDensity: VisualDensity.adaptivePlatformDensity,
//       // ),
//       home: userIsLoggedIn != null ?  userIsLoggedIn! ? ChatRoom1() : Authenticate1()
//           : Container(
//         child: Center(
//           child: Authenticate1(),
//         ),
//       ),
//     );
//   }
// }
