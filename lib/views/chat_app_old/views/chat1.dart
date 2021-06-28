import 'dart:io';
import 'package:chat_app_new/views/chat_app_old/helper/constants.dart';
import 'package:chat_app_new/views/chat_app_old/services/database.dart';
import 'package:chat_app_new/views/chat_app_old/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat1 extends StatefulWidget {
  final String chatRoomId;

  Chat1({required this.chatRoomId});

  @override
  _Chat1State createState() => _Chat1State();
}

class _Chat1State extends State<Chat1> {
  late double height, width;
  late String chatRoomId, messageId = "";

  //Stream<QuerySnapshot>? messageStream;
  late String myName, myProfilePic, myUserName, myEmail;

  Stream<QuerySnapshot>? chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data!.docs[index]["message"],
                    sendByMe: Constants1.myName ==
                        snapshot.data!.docs[index]["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants1.myName,
        "message": messageEditingController.text,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
      };

      DatabaseMethods1().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods1().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Freedom',
          style: TextStyle(fontSize: 15,),
        ),
        elevation: 0.0,
        centerTitle: false,
      ),

      //appBarMain(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: chatMessages()),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              color: Color(0XFF2E9BBA).withOpacity(0.2),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageEditingController,
                    style: simpleTextStyle(),
                    decoration: InputDecoration(
                        hintText: "Type a message ...",
                        hintStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        border: InputBorder.none),
                  )),
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      addMessage();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0XFF2E9BBA).withOpacity(0.7),
                            // gradient: LinearGradient(
                            //     colors: [
                            //       const Color(0x36FFFFFF),
                            //       const Color(0x0FFFFFFF)
                            //     ],
                            //     begin: FractionalOffset.topLeft,
                            //     end: FractionalOffset.bottomRight
                            // ),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          "assets/images/send.png",
                          height: 25,
                          width: 25,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Constants {}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox(height: 8,),
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
               // SizedBox(height: 8,),
                Container(
                  //margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.only(
                      top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
                  alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                        sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
                    padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: sendByMe
                            ? BorderRadius.only(
                                topLeft: Radius.circular(23),
                                topRight: Radius.circular(23),
                                bottomLeft: Radius.circular(23))
                            : BorderRadius.only(
                                topLeft: Radius.circular(23),
                                topRight: Radius.circular(23),
                                bottomRight: Radius.circular(23)),
                        color: sendByMe
                            ? Color(0XFF2E9BBA).withOpacity(0.7)
                            : Color(0xFFF5F5F8)
                        //Color(0XFFFAFAFA) ,
                        //    gradient: LinearGradient(
                        //      colors: sendByMe ? [
                        //        const Color(0xff007EF4),
                        //        const Color(0xff2A75BC)
                        //      ]
                        //          : [
                        //    //    const Color(0xFFFAFAFA),
                        //  // const Color(0x1AFFFFFF)
                        //         const Color(0x1AFFFFFF),
                        //         const Color(0x1AFFFFFF)
                        //      ],
                        //    )
                        ),
                    child: Text(message,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
