// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class FacebookSignInHomeScreen extends StatefulWidget {
//   @override
//   _FacebookSignInHomeScreenState createState() =>
//       _FacebookSignInHomeScreenState();
// }
//
// class _FacebookSignInHomeScreenState extends State<FacebookSignInHomeScreen> {
//   bool _isSigningOut = false;
//   var profileData;
//
//   late double height, width;
//
//   //Facebook login async method
//
//   static final FacebookLogin facebookSignIn = new FacebookLogin();
//
//   void onLogOutStatusChanged(bool _isSigningOut, {profileData}) {
//     setState(() {
//       this._isSigningOut = _isSigningOut;
//       this.profileData = profileData;
//     });
//   }
//
//   Future<void> _logOut() async {
//     await facebookSignIn.logOut();
//     print(
//         'User Logged out. Logged out successfully. \nYou are now navigated to Home Page."');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//
//
//     return Scaffold(
//       // backgroundColor: CustomColors.firebaseNavy,
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 48.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Center(
//                 child: Text(
//                   'Welcome User',
//                   style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Image.asset(
//                 "assets/images/girl.jpg",
//                 scale: 5,
//               ),
//               //SizedBox(height: 40),
//
//               // Container(
//               //   height: 200.0,
//               //   width: 200.0,
//               //   decoration: BoxDecoration(
//               //     shape: BoxShape.circle,
//               //     image: DecorationImage(
//               //       fit: BoxFit.fill,
//               //       image: NetworkImage(
//               //         profileData['picture']['data']['url'],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               // SizedBox(height: 28.0),
//               // Text(
//               //   "Logged in as: ${profileData['name']}",
//               //   style: TextStyle(
//               //     fontSize: 20.0,
//               //   ),
//               // ),
//
//
//               // _displayUserData(profileData),
//               Text(
//                 "Login Success",
//                 style: TextStyle(
//                   fontSize: width * 0.08,
//                   fontWeight: FontWeight.bold,
//                   color: CustomColors.firebaseNavy.withOpacity(0.8),
//                 ),
//               ),
//
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
//                 child: Text(
//                   'You are now signed in using your Facebook account. '
//                   'Go to homescreen or to sign out of your account click the "Sign Out" button below.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: CustomColors.firebaseNavy.withOpacity(0.9),
//                       fontSize: 14,
//                       letterSpacing: 0.2),
//                 ),
//               ),
//               // CircleAvatar(
//               //   radius: 80,
//               //   backgroundImage: NetworkImage(.photoURL),
//               // ),
//               // Text(
//               //   profile.displayName,
//               //   style: TextStyle(fontSize: 30),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: FlatButton(
//                   //elevation: 5,
//                   onPressed: () async {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => FurnitureHome()));
//
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40)),
//                   color: CustomColors.firebaseNavy.withOpacity(0.9),
//                   child: Container(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Home',
//                       style: TextStyle(fontSize: 25, color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//
//               Text(
//                 "Or",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 0.05 * width,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               _isSigningOut
//                   ? CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     )
//                   : Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RaisedButton(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(40)),
//                         onPressed: () async {
//                           setState(() {
//                             _isSigningOut = true;
//                           });
//                           print(
//                               'Logged out successfully. \nYou can now navigate to Home Page.');
//
//                           facebookSignIn.isLoggedIn
//                               .then((isLoggedIn) => isLoggedIn ? _logOut() : {});
//
//                           //await Authentication.logOut();
//                           setState(() {
//                             _isSigningOut = false;
//                           });
//                           Navigator.pop(context);
//                         },
//                         color: CustomColors.firebaseNavy.withOpacity(0.9),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             'Sign Out',
//                             style: TextStyle(fontSize: 25, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                   ),
//               //
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   _displayUserData(profileData) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         // Container(
//         //   height: 200.0,
//         //   width: 200.0,
//         //   decoration: BoxDecoration(
//         //     shape: BoxShape.circle,
//         //     image: DecorationImage(
//         //       fit: BoxFit.fill,
//         //       image: NetworkImage(
//         //         profileData['picture']['data']['url'],
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         SizedBox(height: 28.0),
//         Text(
//           "Logged in as: ${profileData}",
//           style: TextStyle(
//             fontSize: 20.0,
//           ),
//         ),
//       ],
//     );
//   }
// }
