// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

part 'user_operation_state.dart';

class UserOperationCubit extends Cubit<UserOperationState> {
  UserOperationCubit() : super(UserOperationInitial());

  _uploadImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      var selectedImage = File(pickedImage.path);
      return selectedImage;
    } else {
      return null;
    }
  }

  Future<String?> updateProfilePhoto() async {
    emit(Waitting());
    final FirebaseStorage storage = FirebaseStorage.instance;

    try {
      var newPhoto = await _uploadImageFromGallery();
      if (newPhoto != null) {
        if (FirebaseAuth.instance.currentUser!.photoURL != null) {
          await storage
              .refFromURL(FirebaseAuth.instance.currentUser!.photoURL!)
              .delete();
        }

        String fileName = basename(newPhoto.path);
        Reference reference = storage.ref(
            'profile_photos/${FirebaseAuth.instance.currentUser!.uid}/$fileName');
        await reference.putFile(newPhoto);
        String downloadUrl = await reference.getDownloadURL();
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadUrl);
        //ubdata user data in firestore
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "user": {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            "displayName": FirebaseAuth.instance.currentUser!.displayName,
            "phoneNumber": FirebaseAuth.instance.currentUser!.phoneNumber,
            "profileimage": FirebaseAuth.instance.currentUser!.photoURL,
          }
        });
        emit(Success());
        return downloadUrl;
      } else {
        emit(UserOperationInitial());
        return null;
      }
    } catch (e) {
      emit(Error(e.toString()));
      return null;
    }
  }

  Future<void> updateDisplayName(String newuserName) async {
    try {
      emit(Waitting());
      await FirebaseAuth.instance.currentUser!.updateDisplayName(newuserName);
      FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      String? fcmToken = await _firebaseMessaging.getToken();
      //ubdata user data in firestore
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "user": {
          'uid': FirebaseAuth.instance.currentUser!.uid,
          "displayName": newuserName,
          "phoneNumber": FirebaseAuth.instance.currentUser!.phoneNumber,
          "profileimage": FirebaseAuth.instance.currentUser!.photoURL,
          'fcmToken': fcmToken,
        }
      });
      emit(Success());
    } on FirebaseAuthException catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<UserDataModel> getUser(uid) async {
    UserDataModel? userData;

    final futureSnapshot =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = futureSnapshot;
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        Map<String, dynamic> user = data['user'];
        userData = UserDataModel(
          uid: user['uid'] ?? '',
          displayName: user['displayName'] ?? '',
          phoneNumber: user['phoneNumber'] ?? '',
          profileImage: user['profileimage'] ?? '',
          fcmToken: user['fcmToken'] ?? '',
        );
      } else {
        // Handle case when the document doesn't exist
      }
    } catch (e) {
      // Handle any errors that might occur during the data fetching process
    }
    return userData!;
  }

  Future<void> signOut() async {
    var box = Hive.box('myBox');
    try {
      emit(Waitting());
      box.put('customToken', null);
      await FirebaseAuth.instance.signOut();
      emit(Success());
    } catch (e) {
      print("===================================================$e");
      emit(Error(e.toString()));
    }
  }
}
