class ProductDataModel {
  late  String title;
  late  String description;
  late  double price;
  late  String? rating;
  late  String category;
  late  String status;

  ProductDataModel({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.status,
  });
  // Constructor with some default values
 ProductDataModel.empty()
      : title = '',
        description = '',
        price = 0,
        rating = null,
        category = '',
        status = '';
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
