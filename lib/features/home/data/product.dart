class ProductDataModel {
  final String title;
  final String description;
  final double price;
  final String? rating;
  final String category;
  final String status;

  ProductDataModel({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.status,
  });
}

class UserDataModel {
  final String uid;
  final String? displayName;
  final String? phoneNumber;
  final String? profileImage;

  const UserDataModel({
    required this.uid,
    required this.displayName,
    required this.phoneNumber,
    required this.profileImage,
  });
}
