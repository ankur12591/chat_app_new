import 'package:chat_app_new/helperfunctions/sharedpref_helper.dart';
import 'package:chat_app_new/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name;

  ChatScreen(this.chatWithUsername, this.name);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String chatRoomId, messageId = "";
  late Stream<QuerySnapshot> messageStream;
  late String myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageTextEdittingController = TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = (await SharedPreferenceHelper().getDisplayName())!;
    myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = (await SharedPreferenceHelper().getUserEmail())!;

    chatRoomId = getChatRoomIdByUsernames(widget.chatWithUsername, myUserName);
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) {
    if (messageTextEdittingController.text != "") {
      String message = messageTextEdittingController.text;

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": lastMessageTs,
        "imgUrl": myProfilePic
      };

      //messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      DatabaseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserName
        };

        DatabaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (sendClicked) {
          // remove the text in the message input field
          messageTextEdittingController.text = "";
          // make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Colors.blue : Color(0xfff1f0f0),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data!.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return
                      // Text(ds["message"],);
                      chatMessageTile(
                          ds["message"], myUserName == ds["sendBy"]);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  getAndSetMessages() async {
    setState(() {});
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 75,
                color: Color(0xFFF4F5FA),
                // color: Colors.black.withOpacity(0.8),
                padding: EdgeInsets.fromLTRB(16, 12, 16, 7),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageTextEdittingController,
                      onChanged: (value) {
                        addMessage(false);
                      },
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type a message",
                          hintStyle: TextStyle(
                            color: Color(0XFF6A62B7).withOpacity(0.9),
                            //color: Colors.white.withOpacity(0.6)
                          )),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    //Spacer(),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0XFF6A62B7).withOpacity(0.8),
                          // color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // bottomSheet: Container(
      //  // height: 80,
      //   alignment: Alignment.bottomCenter,
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Container(
      //       height: 70,
      //       color: Color(0xFFF4F5FA),
      //       // color: Colors.black.withOpacity(0.8),
      //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //       child: Row(
      //         children: [
      //           Expanded(
      //               child: TextField(
      //
      //                 controller: messageTextEdittingController,
      //                 onChanged: (value) {
      //                   //   addMessage(false);
      //                 },
      //                 style: TextStyle(color: Colors.white),
      //                 decoration: InputDecoration(
      //
      //                     border: InputBorder.none,
      //                     hintText: "Type a message",
      //                     hintStyle:
      //                     TextStyle(
      //                       color: Color(0XFF6A62B7).withOpacity(0.9),
      //                       //color: Colors.white.withOpacity(0.6)
      //                     )),
      //               )),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           //Spacer(),
      //           GestureDetector(
      //             onTap: () {
      //               //  addMessage(true);
      //             },
      //             child: Container(
      //               height: 50,
      //               width: 50,
      //               decoration: BoxDecoration(
      //                 color: Color(0XFF6A62B7).withOpacity(0.8),
      //                 // color: Colors.black.withOpacity(0.7),
      //                 borderRadius: BorderRadius.circular(30),
      //               ),
      //               padding: EdgeInsets.all(8),
      //               child: Icon(
      //                 Icons.send,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ) ,
    );
  }
}
