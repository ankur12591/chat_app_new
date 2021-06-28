import 'dart:ui';

import 'package:chat_app_new/common/components/title_text.dart';
import 'package:chat_app_new/services/auth.dart';
import 'package:chat_app_new/views/chat_app_old/helper/authenticate.dart';
import 'package:chat_app_new/views/chat_app_old/helper/constants.dart';
import 'package:chat_app_new/views/chat_app_old/helper/helperfunctions.dart';
import 'package:chat_app_new/views/chat_app_old/helper/theme.dart';
import 'package:chat_app_new/views/chat_app_old/services/auth.dart';
import 'package:chat_app_new/views/chat_app_old/services/auth_google.dart';
import 'package:chat_app_new/views/chat_app_old/services/database1.dart';
import 'package:chat_app_new/views/chat_app_old/views/chat.dart';
import 'package:chat_app_new/views/chat_app_old/views/chat1.dart';
import 'package:chat_app_new/views/chat_app_old/views/search.dart';
import 'package:chat_app_new/views/chat_app_old/views/search1.dart';
import 'package:chat_app_new/views/chat_app_old/views/signin.dart';
import 'package:chat_app_new/views/chat_app_old/views/signin_with_google.dart';
import 'package:chat_app_new/views/sign_in/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom1 extends StatefulWidget {
  @override
  _ChatRoom1State createState() => _ChatRoom1State();
}

class _ChatRoom1State extends State<ChatRoom1> {
  late double height, width;
  bool isSearching = false;
  String? myProfilePic, userName, myEmail;
  String? myName;
  late Stream<QuerySnapshot> usersStream;
  Stream<QuerySnapshot>? chatRoomsStream;

  TextEditingController searchUsernameEditingController =
      TextEditingController();

  Stream<QuerySnapshot>? chatRooms;

  bool _isSigningOut = false;

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ?
            // ListView.builder(
            //         itemCount: snapshot.data!.docs.length,
            //         shrinkWrap: true,
            //         itemBuilder: (context, index) {
            //
            //
            //             DocumentSnapshot ds = snapshot.data!.docs[index];
            //           return
            //
            //
            //
            //
            //             // //  Text(myUserName);
            //             ChatRoomsTile(
            //               ds["lastmessage"],
            //                //ds["name"],
            //
            //               ds.id,
            //
            //              // userName,
            //               //name: myName,
            //
            //               //  ds["name"],
            //
            //               // ds["myUserName"]
            //             );
            //
            //           //  Text(chatRoomId);
            //           //   ChatRoomsTile(
            //           //   userName: snapshot.data!.docs[index]['chatRoomId']
            //           //       .toString()
            //           //       .replaceAll("_", "")
            //           //       .replaceAll(Constants1.myName, ""),
            //           //   chatRoomId: snapshot.data!.docs[index]["chatRoomId"],
            //           //   name: snapshot.data!.docs[index]["chatRoomId"] .toString()
            //           //       .replaceAll("_", "")
            //           //       .replaceAll(Constants1.myName, ""),
            //           // //  profilePicUrl: snapshot.data!.docs[index].id,
            //           //  );
            //         })

            ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return
                      //  Text(myUserName);
                      ChatRoomsTile(
                    userName: snapshot.data!.docs[index]['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants1.myName, ""),
                    chatRoomId: snapshot.data!.docs[index]["chatRoomId"],

                    //  ds["name"],

                    // ds["myUserName"]
                  );
                })
            : Container();
      },
    );
  }

  // getChatRooms() async {
  //   chatRooms = await DatabaseMethods1().getChatRooms();
  //   setState(() {});
  // }

  // onScreenLoaded() async {
  //   await getUserInfogetChats();
  //   getChatRooms();
  //   setState(() {});
  // }

  @override
  void initState() {
    getUserInfogetChats();
    // onScreenLoaded();
    // getThisUserInfo();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants1.myName = (await HelperFunctions1.getUserNameSharedPreference())!;
    Constants1.myDisplayName =
        (await HelperFunctions1.getDisplayNameSharedPreference())!;
    Constants1.myProfilePic =
        (await HelperFunctions1.getProfilePicSharedPreference())!;
    DatabaseMethods1()
        .
        //  getUserChats(myUserName)
        getUserChats(Constants1.myName)
        .then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants1.myName} , "
            "this is display name ${Constants1.myDisplayName} , "
            "this is profile pic ${Constants1.myProfilePic}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0XFF2E9BBA),
      //Color(0XFF6A62B7),
      appBar: AppBar(
        title: Text(
          'Freedom',
          style: TextStyle(fontSize: 22,
          ),
        ),
        // Image.asset(
        //   "assets/images/logo.png",
        //   height: 40,
        // ),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () async {
              // AuthService().signOut();
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) =>
              //
              //         Authenticate1()
              //  )
              //  );

              setState(() {
                _isSigningOut = true;
              });
              // await AuthMethods().signOut();
              await AuthMethodsGoogle().signOut().then((s) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInGoogle()
                        //    SignInScreen()
                        ));
              });

              // await Authentication.signOut(context: context);
              print(
                  'Logged out successfully. \nYou can now navigate to Home Page.');
              setState(() {
                _isSigningOut = false;
              });
              // Navigator.of(context)
              //     .pushReplacement(_routeToSignInScreen());
              //},
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //  color: Colors.blueGrey,
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 80,
              ),

              // searchUsersList()
              SizedBox(height: height * 0.07),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      //color: Color(0XFFF9F9F9),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Recent Chats',
                              style: TextStyle(
                                  color: Colors.black87.withOpacity(0.7),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500)
                              // style: ,
                              ),
                          Spacer(),
                          Icon(Icons.more_vert_rounded)
                        ],
                      ),
                      Container(
                        child: chatRoomsList(),
                      ),
                      // isSearching ? searchUsersList() : chatRoomsList(),
                    ],
                  ))
            ],
          ),
        ),
      ),

      // Container(
      //   child: chatRoomsList(),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search1()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatefulWidget {
  late final String userName;

  late final String chatRoomId;

// late  final String lastMessage;
  // final String profilePicUrl;
  // final String name;

  ChatRoomsTile({
    required this.userName,
    required this.chatRoomId,
    //required this.lastMessage,
    //  required this.name
  });

  @override
  State<ChatRoomsTile> createState() => _ChatRoomsTileState();
}

class _ChatRoomsTileState extends State<ChatRoomsTile> {
  late String profilePicUrl = "", name = "", userName = "";

  getThisInfo() async {
    print("profile_pic::" + userName);
  }

  @override
  void initState() {
    getThisInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat1(
                      chatRoomId: widget.chatRoomId,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 5, left: 15, right: 15),
        // margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        decoration: BoxDecoration(
            color: Color(0XFF2E9BBA).withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)
            // BorderRadius.only(
            //   topRight: Radius.circular(20.0),
            //   bottomRight: Radius.circular(20.0),
            // ),
            ),
        // color: Colors.black26,
        // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Color(0XFF2E9BBA),
                  //color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(widget.userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(widget.userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w400)),
            SizedBox(
              width: 12,
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(30),
            //   child: Image.network(
            //     Constants1.myProfilePic,
            //     height: 40,
            //     width: 40,
            //   ),
            // ),
            // Text(widget.name,
            //     textAlign: TextAlign.start,
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 16,
            //         fontFamily: 'OverpassRegular',
            //         fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
