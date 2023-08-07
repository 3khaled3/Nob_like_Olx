import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  File? _selectedImage;

  Future<File?>? uploadImageFromGallery() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    XFile? pickedImage =
        // ignore: deprecated_member_use
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      // emit(success());
      return _selectedImage;
    } else {
      return null;
      // Navigate back if no image selected
    }
  }
}
