// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:onboarding_screen/screens/sign_in/facebook_login_home_screen.dart';
//
// class FacebookSignInButton extends StatefulWidget {
//   @override
//   _FacebookSignInButtonState createState() => _FacebookSignInButtonState();
// }
//
// class _FacebookSignInButtonState extends State<FacebookSignInButton> {
//   String successMessage = '';
//   bool _isSigningIn = false;
//
//   // Facebook Sign In & Sign Out methods
//
//   static final FacebookLogin facebookSignIn = new FacebookLogin();
//
//   late String _message;
//
//   var profileData;
//
//   Future<dynamic> _login() async {
//     setState(() {
//       _isSigningIn = true;
//     });
//
//     final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
//
//     switch (result.status) {
//       case FacebookLoginStatus.loggedIn:
//         final FacebookAccessToken accessToken = result.accessToken;
//         final String token = result.accessToken.token;
//         final response = await http.get(Uri.parse(
//             'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));
// //        final profile = jsonDecode(response.body);
//         final profile = Map<String, dynamic>.from(json.decode(response.body));
//         print(profile.toString());
//
//         onLoginStatusChanged(true, profileData: profile);
//         break;
//
//       // print(profile);
//       // return profile;
//
//       // _showMessage('''
//       //  Logged in!
//       //
//       //  Token: ${accessToken.token}
//       //  User id: ${accessToken.userId}
//       //
//       //  Expires: ${accessToken.expires}
//       //  Permissions: ${accessToken.permissions}
//       //  Declined permissions: ${accessToken.declinedPermissions}
//       //  ''');
//       // break;
//       case FacebookLoginStatus.cancelledByUser:
//         _showMessage('Login cancelled by the user.');
//
//         facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
//         break;
//
//       case FacebookLoginStatus.error:
//         _showMessage('Something went wrong with the login process.\n'
//             'Here\'s the error Facebook gave us: ${result.errorMessage}');
//         break;
//     }
//   }
//
//   Future<Null> _logOut() async {
//     await facebookSignIn.logOut();
//     _showMessage('Logged out.');
//   }
//
//   void _showMessage(String message) {
//     setState(() {
//       _isSigningIn = true;
//       // var _user = user ;
//       _message = message;
//     });
//   }
//
//   void onLoginStatusChanged(bool _isSigningIn, {profileData}) {
//     setState(() {
//       // this._isSigningIn = _isSigningIn;
//       this.profileData = profileData;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, bottom: 16.0),
//       child: _isSigningIn
//           ? SizedBox(
//               height: 35,
//               width: 35,
//               child: CircularProgressIndicator(
//                 valueColor:
//                     AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
//               ),
//             )
//           : GestureDetector(
//               onTap: () {
//                 _login().then((profile) {
//                   if (profileData != null) {
//                     print(
//                         'Logged in successfully. \nYou are now navigated to Home Page.');
//
//                     setState(() {
//                       _isSigningIn = false;
//                     });
//
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => FacebookSignInHomeScreen()));
//                   } else {
//                     print('Error while Login.');
//                   }
//                 });
//               },
//               child: Container(
//                   height: 50.0,
//                   color: Colors.transparent,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             color: Colors.black,
//                             style: BorderStyle.solid,
//                             width: 1.0),
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(25.0)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Center(
//                             child: ImageIcon(
//                                 AssetImage('assets/icons/facebook.png'),
//                                 size: 22.0)),
//                         SizedBox(width: 10.0),
//                         Center(
//                             child: Text(
//                           'Login with facebook',
//                         )),
//                       ],
//                     ),
//                   )),
//             ),
//     );
//   }
// }
