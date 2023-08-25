// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nob/features/Chat/data/message_data_model.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

import '../../getUserUsingUid.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

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
            "timestamp": (messageData['timestamp'] as Timestamp).toDate(),
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
      print("==========11111111111111111111============");
      // sendNotification
      await sendNotification(
          message: MessageDataModel(
            type: newMessage['type'],
            timestamp: newMessage['timestamp'],
            content: newMessage['content'],
            receiver: newMessage['receiver'],
            sender: newMessage['sender'],
            isRead: newMessage['isRead'],
          ),
          receiver: receiver);
      print("==========2222222222222222222222============");
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

  Future<void> sendNotification(
      {required MessageDataModel message, required String receiver}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (receiver != auth.currentUser!.uid) {
      final user = await getUserUsingUid(receiver);

      String receiverDeviceToken = user.fcmToken!;
      if (message.type == "String") {
        await post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAXHZNpqE:APA91bGWgQVFKCBF9pTd2IpBiDLg4aBUGgC7eYlusU3hapKiDVyUGOZvBL9eJQx3DAAvQjEeg1qraSWPA3n0cyKUnJ9U4dzEfazgiPz3Ea4adhLrZ9Acao9vvScV9DBolZiHE2Bpfrnb',
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': message.content,
                'title': user.displayName,
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': message.content.hashCode,
                'status': 'done'
              },
              'to': receiverDeviceToken,
            },
          ),
        );
      } else {
        await post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAXHZNpqE:APA91bGWgQVFKCBF9pTd2IpBiDLg4aBUGgC7eYlusU3hapKiDVyUGOZvBL9eJQx3DAAvQjEeg1qraSWPA3n0cyKUnJ9U4dzEfazgiPz3Ea4adhLrZ9Acao9vvScV9DBolZiHE2Bpfrnb',
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'title': user.displayName,
                'body': "Image",
                'image': message.content,
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': message.content.hashCode,
                'status': 'done'
              },
              'to': receiverDeviceToken,
            },
          ),
        );
      }
    }
  }
}
