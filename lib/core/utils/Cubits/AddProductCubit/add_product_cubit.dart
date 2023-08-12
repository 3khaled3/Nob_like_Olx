// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:path/path.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  File? _selectedImage;
  List<File?> selectedImages = [];
  UserDataModel user = UserDataModel(
    uid: FirebaseAuth.instance.currentUser!.uid,
    displayName: FirebaseAuth.instance.currentUser!.displayName,
    phoneNumber: FirebaseAuth.instance.currentUser!.displayName,
    profileImage: FirebaseAuth.instance.currentUser!.photoURL,
  );

  Future<File?>? uploadImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      selectedImages.add(_selectedImage);
      emit(Success());
      return _selectedImage;
    } else {
      return null;
      // Navigate back if no image selected
    }
  }

  Future<String?> uploadAds({required ProductDataModel Product}) async {
    emit(Waitting());
    try {
      List<String> images = [];
      String downloadUrl = "";
      for (var i = 0; i < selectedImages.length; i++) {
        final FirebaseStorage storage = FirebaseStorage.instance;
        String fileName = basename(selectedImages[i]!.path);        
        Reference reference = storage
            .ref('ads/${FirebaseAuth.instance.currentUser!.uid}/$fileName/$fileName');
        await reference.putFile(selectedImages[i]!);
        downloadUrl = await reference.getDownloadURL();
        images.add(downloadUrl);
      }

      if (selectedImages.isNotEmpty) {
        CountAds(); //not important to await
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('ads');
        final DocumentSnapshot Snaps = await usersCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        List<dynamic> ads = [];

        if (Snaps.exists) {
          final Map<String, dynamic> data =
              Snaps.data() as Map<String, dynamic>;
          ads = data["ads"] as List<dynamic>;
        }
        Product.images.addAll(images);

        ads.add({
          "user": {
            'uid': user.uid,
            "displayName": user.displayName,
            "phoneNumber": user.phoneNumber,
            "profileimage": user.profileImage,
          },
          "product": {
            'titel': Product.title,
            'describiton': Product.description,
            'categore': Product.category,
            'Price': Product.price,
            'status': Product.status,
            "AdImage": images
          }
        });

        await FirebaseFirestore.instance
            .collection('ads')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({"ads": ads});
        images.clear();
        print(images.length);
        emit(Success());
        return downloadUrl;
      } else {
        emit(Error("errrrrrrror"));
        return null;
      }
    } catch (e) {
      emit(Error(e.toString()));
      print(e.toString());
      return null;
    }
  }

  Future<int> CountAds() async {
    CollectionReference CountAds =
        FirebaseFirestore.instance.collection('adscount');
    final DocumentSnapshot UserAdsCount =
        await CountAds.doc(FirebaseAuth.instance.currentUser!.uid).get();
    int AdsNum = 0;
    if (UserAdsCount.exists) {
      Map<String, dynamic>? data = UserAdsCount.data() as Map<String, dynamic>?;
      AdsNum = data!['ads'];
    }
    AdsNum++;
    await CountAds.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      "ads": AdsNum,
    });
    return AdsNum;
  }

  // _getCurrentData() async {
  //   List<String> images = [];
  //   try {
  //     DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('stores')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();

  //     if (snapshot.exists) {
  //       Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  //       if (data != null) {
  //         List<dynamic> storyUrls = data['storyURL'];
  //         List<String> stories =
  //             storyUrls.map((url) => url.toString()).toList();
  //         return stories;
  //       }
  //     } else {
  //       return images;
  //     }

  //     // Return an empty list if the document doesn't exist or encounters an error
  //     return images;
  //   } catch (e) {
  //     return images;
  //   }
  // }
}
