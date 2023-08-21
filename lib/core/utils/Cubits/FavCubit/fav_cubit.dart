import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  addToFav(id) async {
    emit(Waitting());
    DocumentSnapshot<Map<String, dynamic>> querySnaps = await FirebaseFirestore
        .instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    Map<String, dynamic> allFavorite = {};
    if (querySnaps.exists) {
      Map<String, dynamic>? favoriteData = querySnaps.data();

      if (favoriteData != null) {
        allFavorite.addAll(favoriteData);
      }
    }

    List fav = [];
    fav.addAll(allFavorite["favorite"] ?? []);
//test is id aleady not fav - if in fav remove it
    bool exist = false;
    for (var i = 0; i < fav.length; i++) {
      if (fav[i] == id) {
        fav.removeAt(i);
        exist = true;
      }
    }
    if (!exist) {
      fav.add(id);
    }

    await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({"favorite": fav});
    emit(Succes());
  }
}
