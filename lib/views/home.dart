import 'package:chat_app_new/helperfunctions/sharedpref_helper.dart';
import 'package:chat_app_new/services/auth.dart';
import 'package:chat_app_new/services/database.dart';
import 'package:chat_app_new/theme.dart';
import 'package:chat_app_new/views/chatscreen.dart';
import 'package:chat_app_new/views/sign_in/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double height, width;
  bool isSearching = false;
  String? myName, myProfilePic, myUserName, myEmail;
  late Stream<QuerySnapshot> usersStream;
  Stream<QuerySnapshot>? chatRoomsStream;

  TextEditingController searchUsernameEditingController =
  TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = (await SharedPreferenceHelper().getDisplayName())!;
    myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = (await SharedPreferenceHelper().getUserEmail())!;
    setState(() {});
  }

  //
  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  //
  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await DatabaseMethods()
        .getUserByUserName(searchUsernameEditingController.text);

    setState(() {});
  }

  //
  Widget searchListUserTile(
      {required String? profilePicUrl, name, username, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames(myUserName!, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(username, name, profilePicUrl!)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                profilePicUrl!,
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(name), Text(email)])
          ],
        ),
      ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return
              //Image.network(ds["imgUrl"]);

              searchListUserTile(
                  profilePicUrl: ds["imgUrl"],
                  name: ds["name"],
                  email: ds["email"],
                  username: ds["username"]);
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ?
        ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return
                //  Text(myUserName);
                ChatRoomListTile(
                  ds["lastMessage"],
                  // ds["chatRoomId"],
                  ds.id,
                  myUserName!,
                  //  ds["name"],

                  // ds["myUserName"]
                );
            })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
    setState(() {});
  }

  @override
  void initState() {
    // getMyInfoFromSharedPreference();
    onScreenLoaded();
    //onSearchBtnClick();
    // getChatRooms();
    //chatRoomsList();
    // searchUsersList();
    // searchUsersList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0XFF6A62B7),
      appBar: AppBar(
        //elevation: 15,
        automaticallyImplyLeading: false,
        //backgroundColor: theme(),
        title: Text("Chat App"),
        // leading:
        // IconButton(
        //   icon: SvgPicture.asset(
        //     "assets/icons/arrow-long-left.svg", color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        actions: [
          GestureDetector(
            onTap: () {
              AuthMethods().signOut().then((s) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //  color: Colors.pink[50],
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      // AuthMethods().signOut().then((s) {
                      //   Navigator.pushReplacement(context,
                      //       MaterialPageRoute(builder: (context) => SignInScreen()));
                      // });
                    },
                    child: Container(
                      //  padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(Icons.exit_to_app)),
                  ),
                  // Icon(Icons.add,color: Colors.pink,size: 20,),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     AuthMethods().signOut().then((s) {
          //       Navigator.pushReplacement(context,
          //           MaterialPageRoute(builder: (context) => SignInScreen()));
          //     });
          //   },
          //   child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 16),
          //       child: Icon(Icons.exit_to_app)),
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //  color: Colors.blueGrey,
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  isSearching
                      ? GestureDetector(
                    onTap: () {
                      isSearching = false;
                      searchUsernameEditingController.text = "";
                      setState(() {});
                    },
                    child: Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.arrow_back)),
                  )
                      : Container(),
                  Expanded(
                    child: Container(
                      margin:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                controller: searchUsernameEditingController,
                                decoration: InputDecoration(
                                  //filled: true,
                                  //fillColor: Colors.white,

                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: "Search Username",
                                    hintStyle: TextStyle(color: Colors.white)),
                              )),
                          GestureDetector(
                              onTap: () {
                                if (searchUsernameEditingController.text !=
                                    "") {
                                  onSearchBtnClick();
                                }
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
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
                      isSearching ? searchUsersList() : chatRoomsList(),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0XFF6A62B7),
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Chats"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text("Groups"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  late final String lastMessage, chatRoomId, myUsername;

  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  late String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    print("chatRoomID:::" +
        widget.chatRoomId
            .replaceAll(widget.myUsername, "")
            .replaceAll("_", ""));
    //print("MyuserName::"+widget.myUsername);
    //print("profile_pic::"+w)
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    print("UserName;;;;;;;;;;;;;;;;;;" + username);

    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);

    print(
        "something bla bla ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["name"]}  ${querySnapshot.docs[0]["imgUrl"]}");
    name = "${querySnapshot.docs[0]["name"]}";
    profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(username, name, profilePicUrl)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        // margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Color(0XFF6A62B7).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)
          // BorderRadius.only(
          //   topRight: Radius.circular(20.0),
          //   bottomRight: Radius.circular(20.0),
          // ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                profilePicUrl,
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //widget.myUsername,
                  name,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 3),
                Text(
                  widget.lastMessage,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}