import 'package:chat_app_new/services/auth.dart';
import 'package:chat_app_new/views/chat_app_old/helper/authenticate.dart';
import 'package:chat_app_new/views/chat_app_old/helper/constants.dart';
import 'package:chat_app_new/views/chat_app_old/helper/helperfunctions.dart';
import 'package:chat_app_new/views/chat_app_old/helper/theme.dart';
import 'package:chat_app_new/views/chat_app_old/services/auth.dart';
import 'package:chat_app_new/views/chat_app_old/services/database.dart';
import 'package:chat_app_new/views/chat_app_old/views/chat.dart';
import 'package:chat_app_new/views/chat_app_old/views/search.dart';
import 'package:chat_app_new/views/chat_app_old/views/signin.dart';
import 'package:chat_app_new/views/sign_in/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream<QuerySnapshot>? chatRooms;

  bool _isSigningOut = false;

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data!.docs[index]['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants1.myName, ""),
                    chatRoomId: snapshot.data!.docs[index]["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants1.myName = (await HelperFunctions1.getUserNameSharedPreference())!;
    DatabaseMethods1().getUserChats(Constants1.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants1.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 40,
        ),
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
              await AuthMethods().signOut().then((s) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>
                    SignIn()
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
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({required this.userName, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
