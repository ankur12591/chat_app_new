import 'package:chat_app_new/helperfunctions/sharedpref_helper.dart';
import 'package:chat_app_new/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name,profilePicUrl;

  ChatScreen(this.chatWithUsername, this.name, this.profilePicUrl);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late double height, width;
  late String chatRoomId, messageId = "";
  Stream<QuerySnapshot>? messageStream;
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
                color: sendByMe ?
              //  Color(0XFFF9F9F9)
                Color(0XFF6A62B7).withOpacity(0.6)
                    : Color(0xfff1f0f0),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.black),
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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0XFF6A62B7),
        appBar: AppBar(
          title: Center(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    widget.profilePicUrl,
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(width: width * 0.03),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.name),
                    Text("")
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/arrow-long-left.svg",
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Icon(Icons.more_vert_rounded)
          ],
        ),
        body: SingleChildScrollView
          (
          child: Column(
            children: [
             // Container(height: 30,),
              SizedBox(height: height * 0.07),
              Container(
                padding: EdgeInsets.only(bottom: 140,top: 50),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      //color: Color(0XFFF9F9F9),
                       color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: chatMessages()),
             // SizedBox(height: 15,)

            ],
          ),
        ),
        bottomSheet: Container(
          height: 75,
          color: Colors.white,
          //color: Color(0xFFF4F5FA),
          // color: Colors.black.withOpacity(0.8),
          padding: EdgeInsets.fromLTRB(2, 12, 2, 12),
          child: Row(
            children: [
              Expanded(
                child: Container(
              //    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 1.2),
                  padding: EdgeInsets.only(left: 1.5),
                  decoration: BoxDecoration(
                    //color: Colors.black,
                    color: Color(0xFFF4F5FA),
                    // color: kPrimaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.02),
                      Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        // color: Theme.of(context)
                        //     .textTheme
                        //     .bodyText1!
                        //     .color!
                        //     .withOpacity(0.64),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                          child: TextField(
                        controller: messageTextEdittingController,
                        onChanged: (value) {
                          addMessage(false);
                        },
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          enabled: true,
                            // color: Color(0xFFF4F5FA),
                            border: InputBorder.none,
                            hintText: "Type message",
                            hintStyle: TextStyle(
                              color: Color(0XFF6A62B7).withOpacity(0.9),
                              //color: Colors.white.withOpacity(0.6)
                            )),
                      )),
                      SizedBox(width: width * 0.02),
                      Icon(
                        Icons.attach_file,
                        // color: Theme.of(context)
                        //     .textTheme
                        //     .bodyText1!
                        //     .color!
                        //     .withOpacity(0.64),
                      ),
                      SizedBox(width: width * 0.02),
                      // SizedBox(width: kDefaultPadding / 4),
                      Icon(
                        Icons.camera_alt_outlined,
                        // color: Theme.of(context)
                        //     .textTheme
                        //     .bodyText1!
                        //     .color!
                        //     .withOpacity(0.64),
                      ),
                      SizedBox(width: width * 0.02),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5,
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
        )
    );
  }
}
