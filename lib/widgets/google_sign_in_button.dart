import 'package:chat_app_new/services/authentication.dart';
import 'package:chat_app_new/views/sign_in/google_login_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;
  late double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 16.0),
      child: _isSigningIn
          ? SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF6A62B7)),
              ),
            )
          : GestureDetector(
              onTap: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => GoogleSignInHomeScreen(
                        user: user,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                height: 50.0,
                width: width * 0.5,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SvgPicture.asset(
                          "assets/icons/google-icon.svg",
                          height: 22.0,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Center(
                          child: Text(
                        'Login with google',
                        //style: TextStyle(fontFamily: 'Trueno')
                      )),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
