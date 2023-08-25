import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/home/data/product.dart';

Future<UserDataModel> getUserUsingUid(String searchQuery) async {
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
