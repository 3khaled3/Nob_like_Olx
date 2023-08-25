import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/features/Chat/data/message_data_model.dart';
import 'package:nob/features/home/data/product.dart';

import '../../getUserUsingUid.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

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
            fcmToken: x["fcmToken"],
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
            type: messageData['type'],
            timestamp: (messageData['timestamp'] as Timestamp).toDate(),
            content: messageData['content'],
            receiver: messageData['receiver'],
            sender: messageData['sender'],
            isRead: messageData['isRead'],
          ));
        }
      }
    }
    return messages;
  }

// Stream for Contact Screen
  Stream<List<Map<String, dynamic>>> getChatsStream() {
    return FirebaseFirestore.instance
        .collection('chat')
        .snapshots()
        .asyncMap<List<Map<String, dynamic>>>((chatQuerySnapshot) async {
      List<Map<String, dynamic>> chats = [];
      List<String> uidsReceiver = [];

      for (var documentSnapshot in chatQuerySnapshot.docs) {
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
        UserDataModel? user = await getUserUsingUid(uidsReceiver[i]);
        List<MessageDataModel> messages = await _fetchMessages(uidsReceiver[i]);
        int notReadCount = 0;
        for (var i = 0; i < messages.length; i++) {
          if (messages[i].receiver == FirebaseAuth.instance.currentUser!.uid) {
            if (messages[i].isRead == false) {
              notReadCount++;
            }
          }
        }

        chats.add({
          "user": user,
          "notread": notReadCount,
          "messages": messages,
        });
      }

      return chats;
    });
  }
}
