import 'package:chat_app_new/common/constants.dart';
import 'package:chat_app_new/services/authentication.dart';
import 'package:chat_app_new/views/sign_in/components/sign_in_form.dart';
import 'package:chat_app_new/widgets/facebook_sign_in_button.dart';
import 'package:chat_app_new/widgets/google_sign_in_button.dart';
import 'package:chat_app_new/widgets/google_sign_in_button_chat_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatelessWidget {
  late double height, width;



  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0XFF6A62B7),
      // appBar: AppBar(
      //   title: Text("Sign In"),
      // ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.06 * width,
                    //getProportionateScreenWidth(20)
                  ),
                  child: SizedBox(height: height * 0.09),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.06 * width,
                    //getProportionateScreenWidth(20)
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello!!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 34,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text('Welcome Back',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.07),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0XFFF9F9F9),
                      // color: Color(0xFFfff7ed),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.08 * width,
                      //getProportionateScreenWidth(20)
                    ),
                    child: Column(
                      children: [
                        // Container(
                        //     child: SignInForm()
                        // ),

                        // Text(
                        //   "Or",
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 0.05 * width,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),

                        SizedBox(height: height * 0.15),

                       // Spacer(flex: 3,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            horizontalLine(),
                            Text("Social Login",
                                style: TextStyle(color: Colors.black87.withOpacity(0.7),
                                    fontSize: 18.0, )),
                            horizontalLine()
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        //GoogleSignInButton(),
                        FutureBuilder(
                          future: Authentication.initializeFirebase(
                              context: context),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error initializing Firebase');
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              //return GoogleSignInButton();
                              return GoogleSignInButtonChatApp();
                            }
                            return CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0XFF6A62B7),
                                //CustomColors.firebaseOrange,
                              ),
                            );
                          },
                        ),
                        // SizedBox(height: height * 0.02),
                        //   FacebookSignInButton(),
                        //SizedBox(height: height * 0.02),

                        // SizedBox(height: height * 0.04),
                        // Container(
                        //   //color: Colors.amber,
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         "Don’t have an account? ",
                        //         style: TextStyle(fontSize: width * 0.044),
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {},
                        //         // => Navigator.push(
                        //         //     context,
                        //         //     MaterialPageRoute(
                        //         //         builder: (context) => SignUpScreen())),
                        //         child: Text(
                        //           "Sign Up",
                        //           style: TextStyle(
                        //               fontSize: width * 0.044,
                        //               color: Color(0XFF6A62B7)),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        //  Spacer(),
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 20),
                        //   padding: EdgeInsets.only(top: 20, bottom: 30),
                        //   height: 4,
                        //   width: width * 0.55,
                        //   color: Color(0XFF6A62B7),
                        // )

                        SizedBox(height: 0.03 * height,),
                        // NoAccountText(),
                        // SizedBox(height: height * 0.08),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: width * 0.18,
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );
}
