// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:nob/constant.dart';

part 'fitch_product_state.dart';

class FitchProductCubit extends Cubit<FitchProductState> {
  FitchProductCubit() : super(FitchProductInitial());
Future<Map<String, List>> getdata() async {
  // Emit a waiting state here if needed
  emit(Waitting());

  // Reference to the Firestore collection
  CollectionReference adsCollection =
      FirebaseFirestore.instance.collection('ads');

  // Get all documents from the 'ads' collection
  QuerySnapshot querySnapshot = await adsCollection.get();

  List<dynamic> ads = [];

  // Process each document in the query result
  for (var documentSnapshot in querySnapshot.docs) {
    if (documentSnapshot.exists) {
      // Extract 'ads' array from the document data
      final Map<String, dynamic> data = documentSnapshot.data()
          as Map<String, dynamic>;
      ads.addAll(data["ads"] as List<dynamic>);
    }
  }

  // Extract category names from 'categories' data
  final List<String> Categories = categories
      .map((categoryData) => categoryData.keys.first)
      .toList();

  // Map to hold categorized products
  Map<String, List> products = {};

  // Categorize products based on their 'categore' field
  for (var i = 0; i < Categories.length; i++) {
    products[Categories[i]] = [];
    for (var x = 0; x < ads.length; x++) {
      if (ads[x]["product"]["categore"] == Categories[i]) {
        products[Categories[i]]?.add(ads[x]);
      }
    }
  }

  // Remove categories with no products
  products.removeWhere((category, products) => products.isEmpty);

  return products;
}
}