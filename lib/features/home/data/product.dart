class ProductDataModel {
  late String id;
  bool favorte;
  late String title;
  late String description;
  late double price;
  late String? rating;
  late String category;
  late String status;

  List<dynamic> images;

  ProductDataModel({
    required this.favorte,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.status,
    required this.images,
  });
  // Constructor with some default values
  ProductDataModel.empty()
      : title = '',
        favorte = false,
        id = '',
        description = '',
        price = 0,
        rating = null,
        category = '',
        images = [],
        status = '';
}

class UserDataModel {
  final String? uid;
  final String? displayName;
  final String? phoneNumber;
  final String? profileImage;
  final String? fcmToken;

  const UserDataModel({
    required this.fcmToken,
    required this.uid,
    required this.displayName,
    required this.phoneNumber,
    required this.profileImage,
  });
}
