// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nob/features/home/data/product.dart';
import 'package:path/path.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  File? _selectedImage;
  List<File?> selectedImages = [];

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
        String originalFileName = basename(selectedImages[i]!.path);

// Get the current date and time
        String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String currentTime = DateFormat('HH-mm-ss').format(DateTime.now());

// Construct a new file name using the current date and time
        String newFileName = '$currentDate-$currentTime-$originalFileName';

        Reference reference = storage
            .ref('ads/${FirebaseAuth.instance.currentUser!.uid}/$newFileName');

        await reference.putFile(selectedImages[i]!);
        downloadUrl = await reference.getDownloadURL();
        images.add(downloadUrl);
      }

      if (selectedImages.isEmpty) {
        String inithialImage="https://firebasestorage.googleapis.com/v0/b/nob-d0c2f.appspot.com/o/ads%2Fnoimage.png?alt=media&token=9c73de63-970e-4b59-8d5e-e7942dfa34bd";
        images.add(inithialImage);

      }
        int countID = await CountAds();
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
          "id": "${FirebaseAuth.instance.currentUser!.uid} $countID",
          "user": {
            'uid': FirebaseAuth.instance.currentUser!.uid,
          },
          "product": {
            'titel': Product.title,
            'describiton': Product.description,
            'categore': Product.category,
            'Price': Product.price,
            'status': Product.status,
            "AdImage": Product.images,
            "rating": Product.rating,
          }
        });

        await FirebaseFirestore.instance
            .collection('ads')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({"ads": ads});
        images.clear();
        emit(Success());
        return downloadUrl;
      
    } catch (e) {
      emit(Error(e.toString()));
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

}
