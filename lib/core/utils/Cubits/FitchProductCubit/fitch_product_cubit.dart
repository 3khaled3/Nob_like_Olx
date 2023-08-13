// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:nob/constant.dart';

part 'fitch_product_state.dart';

class FitchProductCubit extends Cubit<FitchProductState> {
  FitchProductCubit() : super(FitchProductInitial());

  Future<Map<String, List>> getdata() async {
    emit(Waitting());
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('ads');
    final DocumentSnapshot Snaps =
        await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    List<dynamic> ads = [];

    if (Snaps.exists) {
      final Map<String, dynamic> data = Snaps.data() as Map<String, dynamic>;
      ads = data["ads"] as List<dynamic>;
    }
    final List<String> Categories =
        categories.map((categoryData) => categoryData.keys.first).toList();

    Map<String, List> prodcts = {};
    for (var i = 0; i < Categories.length; i++) {
      prodcts[Categories[i]] = [];
      for (var x = 0; x < ads.length; x++) {
        if (ads[x]["product"]["categore"] == Categories[i]) {
          prodcts[Categories[i]]?.add(ads[x]);
        }
      }
    }
    prodcts.removeWhere((category, products) => products.isEmpty);

    return prodcts;
  }
}
