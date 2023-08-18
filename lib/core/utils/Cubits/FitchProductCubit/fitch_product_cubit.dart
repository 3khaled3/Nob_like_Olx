// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nob/constant.dart';
import '../../../../features/home/data/product.dart';
import '../UserOperationCubit/user_operation_cubit.dart';

part 'fitch_product_state.dart';

class FitchProductCubit extends Cubit<FitchProductState> {
  FitchProductCubit() : super(FitchProductInitial());
  Future<List<List<Map<UserDataModel, ProductDataModel>>>> getdata(
      context) async {
    List<List<Map<UserDataModel, ProductDataModel>>> finalOutput = [];
    Map<String, List> products = {};
    try {
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
          final Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          ads.addAll(data["ads"] as List<dynamic>);
        }
      }

      // Extract category names from 'categories' data
      final List<String> Categories =
          categories.map((categoryData) => categoryData.keys.first).toList();

      // Map to hold categorized products

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

// Iterate through each category
      for (String category in Categories) {
        List<Map<UserDataModel, ProductDataModel>> categoryOutput = [];

        // Iterate through the data points in the current category
        for (var data in products[category] ?? []) {
          Map<String, dynamic>? product = data['product'];
          Map<String, dynamic>? user = data['user'];

          // Skip this data point if either product or user is null
          if (product == null || user == null) {
            continue;
          }

          // Extract product data from the current data point
          ProductDataModel productData = ProductDataModel.empty()
            ..title = product['titel'] ?? ''
            ..description = product['describiton'] ?? ''
            ..category = product['categore'] ?? ''
            ..price = product['Price'] ?? 0
            ..status = product['status'] ?? ''
            ..images = product['AdImage'] ?? []
            ..rating = product['rating'] ?? "";

          // Extract user data from the current data point

          UserDataModel userData =
              await BlocProvider.of<UserOperationCubit>(context)
                  .getUser(user['uid']);
          // Create a map with user data as the key and product data as the value
          categoryOutput.add({
            userData: productData,
          });
        }

        // Add the list of user-product data pairs for the current category to the final output
        finalOutput.add(categoryOutput);
      }

      finalOutput.removeWhere((innerList) => innerList.isEmpty);
    } catch (e) {
      print("========${e.toString()}");
    }

    return finalOutput;
  }
}
