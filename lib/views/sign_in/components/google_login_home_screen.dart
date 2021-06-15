import 'package:chat_app_new/common/constants.dart';
import 'package:chat_app_new/services/auth.dart';
import 'package:chat_app_new/services/authentication.dart';
import 'package:chat_app_new/views/home.dart';
import 'package:chat_app_new/views/other_chat_app/home.dart';
import 'package:chat_app_new/views/sign_in/sign_in_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class GoogleSignInHomeScreen extends StatefulWidget {
  const GoogleSignInHomeScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User? _user;

  @override
  _GoogleSignInHomeScreenState createState() => _GoogleSignInHomeScreenState();
}

class _GoogleSignInHomeScreenState extends State<GoogleSignInHomeScreen> {
  bool _isSigningIn = false;
  bool _isSigningOut = false;

  late User _user;

  late double height, width;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: CustomColors.firebaseNavy,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  'Welcome User',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              SizedBox(height: 40),
              // Image.asset(
              //   "assets/images/girl.jpg",
              //   scale: 5,
              // ),
              //SizedBox(height: 40),
              Container(
                child: _user.photoURL != null
                    ? ClipOval(
                        child: Material(
                          color: CustomColors.firebaseGrey.withOpacity(0.3),
                          child: Image.network(
                            _user.photoURL!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : ClipOval(
                        child: Material(
                          color: CustomColors.firebaseGrey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: CustomColors.firebaseGrey,
                            ),
                          ),
                        ),
                      ),
              ),
              //SizedBox(height: 16.0),

              SizedBox(height: 16.0),
              Text(
                'Hello !!!',
                style: TextStyle(
                  color: CustomColors.firebaseNavy.withOpacity(0.8),
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                _user.displayName!,
                style: TextStyle(
                  color: CustomColors.firebaseOrange,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '( ${_user.email!} )',
                style: TextStyle(
                  color: CustomColors.firebaseOrange,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              //  SizedBox(height: 24.0),
              Text(
                "Login Success",
                style: TextStyle(
                  fontSize: width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.firebaseNavy.withOpacity(0.8),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                child: Text(
                  'You are now signed in using your Google account. '
                  'Go to homescreen or to sign out of your account click the "Sign Out" button below .',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CustomColors.firebaseNavy.withOpacity(0.9),
                      fontSize: 14,
                      letterSpacing: 0.2),
                ),
              ),
              // CircleAvatar(
              //   radius: 80,
              //   backgroundImage: NetworkImage(.photoURL),
              // ),
              // Text(
              //   profile.displayName,
              //   style: TextStyle(fontSize: 30),
              // ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  //elevation: 5,
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                      //  HomeScreen(currentUserId: '',)
                         Home()
                        ));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  //color: Color(0XFF6A62B7),
                  color: CustomColors.firebaseNavy.withOpacity(0.9),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Home',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              Text(
                "Or",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 0.05 * width,
                  fontWeight: FontWeight.bold,
                ),
              ),

              _isSigningOut
                  ? SizedBox(
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0XFF6A62B7)),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        //elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () async {
                          // _logOut();
                          // print(
                          //     'Logged out successfully. \nYou can now navigate to Home Page.');

                          setState(() {
                            _isSigningOut = true;
                          });
                          // await AuthMethods().signOut();
                          await AuthMethods().signOut().then((s) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                          });

                          // await Authentication.signOut(context: context);
                          print(
                              'Logged out successfully. \nYou can now navigate to Home Page.');
                          setState(() {
                            _isSigningOut = false;
                          });
                          Navigator.of(context)
                              .pushReplacement(_routeToSignInScreen());
                        },
                        //     color: Color(0XFF6A62B7),
                        color: CustomColors.firebaseNavy.withOpacity(0.9),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sign Out',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
