import 'package:chat_app_new/views/chat_app_old/helper/helperfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods1 {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance.collection("users1").add(userData).catchError((
        e) {
      print(e.toString());
    });
  }

  // getUserInfo(String email) async {
  //   return FirebaseFirestore.instance
  //       .collection("users1")
  //       .where("userEmail", isEqualTo: email)
  //       .get()
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  getUserInfo(String userName) async {
    return FirebaseFirestore.instance
        .collection("users1")
        .where("userName", isEqualTo: userName)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users1")
        .where('userName', isEqualTo: searchField)
        .get();
  }

  Future<bool?> addChatRoom(chatRoom, chatRoomId) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData, messageId,
      Map<String, dynamic> messageInfoMap) async {
    await FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap)

    //.add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  updateLastMessageSend(String chatRoomId,
      Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  getUserChats(String itIsMyName,) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String? myUsername = await HelperFunctions1.getUserNameSharedPreference();
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }

  Future<QuerySnapshot> getUserNameInfo(String? username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userName", isEqualTo: username)
        .get();
  }
}
