import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/features/Chat/data/message_data_model.dart';
import 'package:nob/features/home/data/product.dart';


part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<List<UserDataModel>> search(String searchQuery) async {
    emit(Waitting());
    List<UserDataModel> users = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where("user.phoneNumber", isEqualTo: searchQuery)
          .get();

      List<Map<String, dynamic>> results = [];
      for (var document in querySnapshot.docs) {
        results.add(document.data() as Map<String, dynamic>);
      }

      for (var user in results) {
        var x = user["user"];
        users.add(UserDataModel(
            uid: x["uid"],
            displayName: x["displayName"],
            phoneNumber: x["phoneNumber"],
            profileImage: x["profileimage"]));
      }
      emit(Success());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      emit(Error(e.toString()));
    }
    return users;
  }

  Future<void> sendMessage({required String message, required receiver}) async {
    // Get chat ID by sorting and concatenating user IDs
    List<String> ids = [FirebaseAuth.instance.currentUser!.uid, receiver];
    ids.sort();
    ids.join("").contains(receiver);

    final newMessage = MessageDataModel(
        content: message,
        timestamp: DateTime.now(),
        sender: FirebaseAuth.instance.currentUser!.uid,
        receiver: receiver,
        isRead: false);

    List<MessageDataModel> messages = await getChat(receiver);
    messages.add(newMessage); // Add the new message to the existing messages
    // Update the chat document with the updated list of messages
    FirebaseFirestore.instance
        .collection("chat")
        .doc(ids.join(" "))
        .set({"messages": messages});
  }

  Future<List<MessageDataModel>> getChat(receiver) async {
    List<MessageDataModel> messages = [];
    // Get chat ID by sorting and concatenating user IDs
    List<String> ids = [FirebaseAuth.instance.currentUser!.uid, receiver];
    ids.sort();
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("chat")
        .doc(ids.join(" "))
        .get();

    if (snapshot.exists) {
      List<dynamic> messageList =
          (snapshot.data() as Map<String, dynamic>)['messages'];
      for (var messageData in messageList) {
        messages.add(MessageDataModel(
          timestamp: (messageData['timestamp'] as Timestamp).toDate(),
          content: messageData['content'],
          receiver: messageData['receiver'],
          sender: messageData['sender'],
        ));
      }
    }
    return messages;
  }

  Future<UserDataModel> _getUserUseingUid(String searchQuery) async {
    UserDataModel? users;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where("user.uid", isEqualTo: searchQuery)
          .get();

      Map<String, dynamic>? results;
      for (var document in querySnapshot.docs) {
        results = (document.data() as Map<String, dynamic>);
      }

      users = UserDataModel(
          uid: results!["user"]["uid"],
          displayName: results["user"]["displayName"],
          phoneNumber: results["user"]["phoneNumber"],
          profileImage: results["user"]["profileimage"]);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return users!;
  }

  Future<List<Map<String, dynamic>>> getusers() async {
    CollectionReference adsCollection =
        FirebaseFirestore.instance.collection('chat');

    // Get all documents from the 'chat' collection
    QuerySnapshot querySnapshot = await adsCollection.get();

    List<Map<String, dynamic>> chats = [];
    List<String> uidsResiver = [];

    // Process each document in the query result
    for (var documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.exists) {
        List<String> uids = documentSnapshot.id.split(" ");
        int? uidcutterntindex;
        for (var i = 0; i < uids.length; i++) {
          if (uids[i] == FirebaseAuth.instance.currentUser!.uid) {
            uidcutterntindex = i;
          }
        }
        if (uidcutterntindex != null) {
          uidcutterntindex == 1
              ? uidsResiver.add(uids[0])
              : uidsResiver.add(uids[1]);
        }
      }
    }
    for (var i = 0; i < uidsResiver.length; i++) {
      final UserDataModel user = await _getUserUseingUid(uidsResiver[i]);
      final List<MessageDataModel> messages = await getChat(uidsResiver[i]);
      int notread = 0;
      for (var i = 0; i < messages.length; i++) {
        if (messages[i].isRead == false) {
          notread++;
        }
      }
      chats.add({"user": user, "notread": notread, "messages": messages});
    }
   return chats; 
  }
}
