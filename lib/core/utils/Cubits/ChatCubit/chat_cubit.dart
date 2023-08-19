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
      print(users);
      emit(Success());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      emit(Error(e.toString()));
    }
    return users;
  }

  Future<void> sendMessage(
      {required String message, required String receiver}) async {
    // Get chat ID by sorting and concatenating user IDs
    List<String> ids = [FirebaseAuth.instance.currentUser!.uid, receiver];
    ids.sort();
    final chatId = ids.join(" ");

    final newMessage = {
      "content": message,
      "timestamp": DateTime.now(),
      "sender": FirebaseAuth.instance.currentUser!.uid,
      "receiver": receiver,
      "isRead": false,
    };

    try {
      // Get the current chat document
      DocumentSnapshot chatDocument =
          await FirebaseFirestore.instance.collection("chat").doc(chatId).get();
      List<Map<String, dynamic>> messages = [];

      if (chatDocument.exists) {
        // If the chat document exists, retrieve its messages
        List<dynamic> messageList =
            (chatDocument.data() as Map<String, dynamic>)['messages'];

        for (var messageData in messageList) {
          Map<String, dynamic> messageMap = {
            "timestamp": (messageData['timestamp'] as Timestamp).toDate(),
            "content": messageData['content'],
            "receiver": messageData['receiver'],
            "sender": messageData['sender'],
            "isRead": messageData['isRead'] ?? false,
          };
          messages.add(messageMap);
        }
      }

      messages.add(newMessage); // Add the new message to the existing messages
      // Update the chat document with the updated list of messages
      print("3333333333333333333333333");
      await FirebaseFirestore.instance
          .collection("chat")
          .doc(chatId)
          .set({"messages": messages});

      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
      print("=====================================");
      print(e.toString());
      print("=====================================");
      // Handle the error as needed
    }
  }

  Stream<List<MessageDataModel>> messagesStream(String receiver) {
    List<String> ids = [FirebaseAuth.instance.currentUser!.uid, receiver];
    ids.sort();
    final chatId = ids.join(" ");

    return FirebaseFirestore.instance
        .collection("chat")
        .doc(chatId)
        .snapshots()
        .map((chatDocument) {
      List<MessageDataModel> messages = [];
      List<Map<String, dynamic>> messageList =
          (chatDocument.data()!['messages'] as List<dynamic>)
              .cast<Map<String, dynamic>>();

      for (var messageData in messageList) {
        messages.add(MessageDataModel(
          timestamp: (messageData['timestamp'] as Timestamp).toDate(),
          content: messageData['content'],
          receiver: messageData['receiver'],
          sender: messageData['sender'],
          isRead: messageData['isRead'] ?? false,
        ));
      }

      return messages;
    });
  }

  Future<List<MessageDataModel>> _fetchMessages(String receiver) async {
    List<String> ids = [FirebaseAuth.instance.currentUser!.uid, receiver];
    ids.sort();
    final chatId = ids.join(" ");

    DocumentSnapshot chatDocument =
        await FirebaseFirestore.instance.collection("chat").doc(chatId).get();

    List<MessageDataModel> messages = [];

    if (chatDocument.exists) {
      Map<String, dynamic> data = chatDocument.data() as Map<String, dynamic>;

      if (data.containsKey('messages') && data['messages'] is List<dynamic>) {
        List<Map<String, dynamic>> messageList =
            (data['messages'] as List<dynamic>)
                .cast<Map<String, dynamic>>()
                .toList();

        for (var messageData in messageList) {
          messages.add(MessageDataModel(
            timestamp: (messageData['timestamp'] as Timestamp).toDate(),
            content: messageData['content'],
            receiver: messageData['receiver'],
            sender: messageData['sender'],
            isRead: messageData['isRead'] ?? false,
          ));
        }
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

  Stream<List<Map<String, dynamic>>> getChatsStream() async* {
    CollectionReference chatCollection =
        FirebaseFirestore.instance.collection('chat');

    QuerySnapshot querySnapshot = await chatCollection.get();

    List<Map<String, dynamic>> chats = [];
    List<String> uidsReceiver = [];

    for (var documentSnapshot in querySnapshot.docs) {
      if (documentSnapshot.exists) {
        List<String> uids = documentSnapshot.id.split(" ");
        int? currentUserIndex;

        for (var i = 0; i < uids.length; i++) {
          if (uids[i] == FirebaseAuth.instance.currentUser!.uid) {
            currentUserIndex = i;
            break;
          }
        }

        if (currentUserIndex != null) {
          int otherUserIndex = 1 - currentUserIndex;
          uidsReceiver.add(uids[otherUserIndex]);
        }
      }
    }

    for (var i = 0; i < uidsReceiver.length; i++) {
      UserDataModel? user = await _getUserUseingUid(uidsReceiver[i]);
      List<MessageDataModel> messages = await _fetchMessages(uidsReceiver[i]);
      int notReadCount = messages.where((message) => !message.isRead).length;

      chats.add({
        "user": user,
        "notread": notReadCount,
        "messages": messages,
      });
    }

    yield chats;
  }
}
