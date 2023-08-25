import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nob/features/Chat/data/message_data_model.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:path/path.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

import '../../notification_handler.dart';
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

  File? _selectedImage;
  Future<File?>? uploadImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      return _selectedImage;
    } else {
      return null;
      // Navigate back if no image selected
    }
  }

  Future<void> sendMessage(
      {required String message, required String receiver}) async {
    // Get chat ID by sorting and concatenating user IDs
    List<String> ids = [FirebaseAuth.instance.currentUser!.uid, receiver];
    String downloadUrl = "";
    ids.sort();
    final chatId = ids.join(" ");

    if (_selectedImage != null) {
      final newimage = _selectedImage;
      _selectedImage = null;
      final FirebaseStorage storage = FirebaseStorage.instance;
      String originalFileName = basename(newimage!.path);

// Get the current date and time
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String currentTime = DateFormat('HH-mm-ss').format(DateTime.now());

// Construct a new file name using the current date and time
      String newFileName =
          '$currentDate-$currentTime-${DateTime.now().millisecond}${DateTime.now().microsecondsSinceEpoch}-$originalFileName';

      Reference reference = storage.ref(
          'massegeImage/${FirebaseAuth.instance.currentUser!.uid}/$newFileName');

      await reference.putFile(newimage);
      downloadUrl = await reference.getDownloadURL();
    }
    Map<String, dynamic> newMessage = {};
    if (downloadUrl.isNotEmpty) {
      newMessage.addAll({
        "type": "File",
        "content": downloadUrl,
        "timestamp": DateTime.now(),
        "sender": FirebaseAuth.instance.currentUser!.uid,
        "receiver": receiver,
        "isRead": false,
      });
      print("==============================");
    } else {
      newMessage.addAll({
        "type": "String",
        "content": message,
        "timestamp": DateTime.now(),
        "sender": FirebaseAuth.instance.currentUser!.uid,
        "receiver": receiver,
        "isRead": false,
      });
    }

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
            "timestamp":  (messageData['timestamp'] as Timestamp).toDate(),
            "content": messageData['content'],
            "receiver": messageData['receiver'],
            "sender": messageData['sender'],
            "isRead": messageData['isRead'],
            "type": messageData['type'],
          };
          messages.add(messageMap);
        }
      }

      messages.add(newMessage); // Add the new message to the existing messages
      // Update the chat document with the updated list of messages
      await FirebaseFirestore.instance
          .collection("chat")
          .doc(chatId)
          .set({"messages": messages});

      print("=========111111111111=============");
      await sendNotification(
          message: MessageDataModel(
            type: newMessage['type'],
            timestamp: newMessage['timestamp'] ,
            content: newMessage['content'],
            receiver: newMessage['receiver'],
            sender: newMessage['sender'],
            isRead: newMessage['isRead'],
          ),
          receiver: receiver);

      print("==========22222222222222222222222============");
      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
      // ignore: avoid_print
      print(e.toString());

      // Handle the error as needed
    }
  }

// Stream for Chat Screen
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
      List<Map<String, dynamic>> messageList = [];
      if (chatDocument.data() != null) {
        List<dynamic>? messagesData =
            chatDocument.data()!['messages'] as List<dynamic>?;
        if (messagesData != null) {
          messageList.addAll(messagesData.cast<Map<String, dynamic>>());
          // Now you can use messageList
        }
      }

      for (var messageData in messageList) {
        if (!messageData['isRead']) {
          messageData['isRead'] =
              messageData['receiver'] == FirebaseAuth.instance.currentUser!.uid;
        }
      }

      FirebaseFirestore.instance
          .collection("chat")
          .doc(chatId)
          .set({"messages": messageList});

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

  Future<UserDataModel> _getUserUsingUid(String searchQuery) async {
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
          profileImage: results["user"]["profileimage"],
          fcmToken: results["user"]["fcmToken"]);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return users!;
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
        UserDataModel? user = await _getUserUsingUid(uidsReceiver[i]);
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

  // Future<void> sendNotification(
  //     {required String message, required String receiver}) async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;

  //   if (receiver != auth.currentUser!.uid) {
  //     final user = await _getUserUsingUid(receiver);

  //     String receiverDeviceToken = user.fcmToken!;

  //     // Send a notification to the specific device token
  //     NotificationHandler.showNotification(
  //       RemoteMessage(
  //         notification: RemoteNotification(
  //           title: user.displayName,
  //           body: message,
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future<void> sendNotification(
      {required MessageDataModel message, required String receiver}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (receiver != auth.currentUser!.uid) {
      final user = await _getUserUsingUid(receiver);

      String receiverDeviceToken = user.fcmToken!;
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAXHZNpqE:APA91bGWgQVFKCBF9pTd2IpBiDLg4aBUGgC7eYlusU3hapKiDVyUGOZvBL9eJQx3DAAvQjEeg1qraSWPA3n0cyKUnJ9U4dzEfazgiPz3Ea4adhLrZ9Acao9vvScV9DBolZiHE2Bpfrnb',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': message.type == "String" ? message.content : "Image",
              'title': user.displayName,
              'image': message.type == "String" ? null : message.content,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': receiverDeviceToken,
          },
        ),
      );
    }
  }
  //     NotificationHandler.showNotification(
  //       RemoteMessage(
  //         notification: RemoteNotification(
  //           title: user.displayName,
  //           body: message,
  //         ),
  //       ),
  //     );
  //   }
  // }
}
