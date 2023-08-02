// // ignore_for_file: depend_on_referenced_packages

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';
// import '../Apicubit/api_cubit.dart';
// import '../FavCubit/fav_cubit.dart';
// part 'user_state.dart';

// class UserCubit extends Cubit<UserState> {
//   UserCubit() : super(UserInitial());
//   String? emailAddress = " a", password = " a", userName = " a";
//   var box = Hive.box('myBox');
//   UserCredential? useraccess;
//   Future<void> createAccountAndSendEmailVerification() async {
//     try {
//       if (emailAddress != null && password != null && userName != null) {
//         emit(Waitting());
//         final credential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailAddress!,
//           password: password!,
//         );
//         User? user = credential.user;
//         await user!.updateDisplayName(userName);
//         await user.sendEmailVerification();

//         emit(Success());
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         emit(Error("The password provided is too weak."));
//       } else if (e.code == 'email-already-in-use') {
//         emit(Error("The account already exists for that email."));
//       } else {
//         emit(Error(e.toString()));
//       }
//     } catch (e) {
//       emit(Error(e.toString()));
//     }
//   }
//   login(context) async {
//     try {
//       emit(Waitting());
//       if (emailAddress != null && emailAddress != null) {
//         final credential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(
//                 email: emailAddress!, password: password!);
//         if (credential.user!.emailVerified == true) {
//           await BlocProvider.of<ApiCubit>(context).fetchcategoriesProducts();
//           await BlocProvider.of<FavCubit>(context).getfav(context);
//           emit(Success());
//           box.put('emailAddress', emailAddress);
//           box.put('password', password);
//            useraccess = credential;
//         } else {
//           User? user = credential.user;
//           await user!.sendEmailVerification();

//           emit(Error("Check your mail and Verifiy your account."));
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         emit(Error("No user found for that email."));
//       } else if (e.code == 'wrong-password') {
//         emit(Error("Wrong password provided for that user."));
//       } else {
//         emit(Error(e.toString()));
//       }
//     }
//   }

//   Future<void> forgetPassword(String email) async {
//     try {
//       emit(Waitting());
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       emit(Success());
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         emit(Error("No user found for that email."));
//       } else {
//         emit(Error(e.toString()));
//       }
//     }
//   }

//   Future<void> updataPassword(String newPassword) async {
//     try {
//       emit(Waitting());
//       await useraccess!.user!.updatePassword(newPassword);
//       emit(Success());
//       box.put('password', newPassword);
//     } on FirebaseAuthException catch (e) {
//       emit(Error(e.toString()));
//     }
//   }

//   Future<void> updateDisplayName(String newuserName) async {
//     try {
//       emit(Waitting());
//       await FirebaseAuth.instance.currentUser!.updateDisplayName(newuserName);
//       emit(Success());
//     } on FirebaseAuthException catch (e) {
//       emit(Error(e.toString()));
//     }
//   }

//   File? _selectedImage;

//   _uploadImageFromGallery() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       _selectedImage = File(pickedImage.path);
//       return _selectedImage;
//     } else {
//       return null;
//     }
//   }

//   Future<String?> updateProfilePhoto() async {
//     emit(Waitting());
//     final FirebaseStorage storage = FirebaseStorage.instance;
//     User? user = FirebaseAuth.instance.currentUser;
//     try {
//       var newPhoto = await _uploadImageFromGallery();
//       if (newPhoto != null) {
//         if (user!.photoURL != null) {
//           await storage.refFromURL(user.photoURL!).delete();
//         }

//         String fileName = basename(newPhoto.path);
//         Reference reference =
//             storage.ref('profile_photos/${user.uid}/$fileName');
//         await reference.putFile(newPhoto);
//         String downloadUrl = await reference.getDownloadURL();
//         await user.updatePhotoURL(downloadUrl);
//         emit(Success());
//         return downloadUrl;
//       } else {
//         emit(UserInitial());
//         return null;
//       }
//     } catch (e) {
//       emit(Error(e.toString()));
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       emit(Waitting());
//       box.put('emailAddress', null);
//       box.put('password', null);
//       await FirebaseAuth.instance.signOut();
//       emit(Success());
//     } catch (e) {
//       emit(Error(e.toString()));
//     }
//   }
// }

// //   Future<UserCredential> signInWithGoogle() async {
// //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// //     final GoogleSignInAuthentication? googleAuth =
// //         await googleUser?.authentication;
// //     final credential = GoogleAuthProvider.credential(
// //       accessToken: googleAuth?.accessToken,
// //       idToken: googleAuth?.idToken,
// //     );

// //     return await FirebaseAuth.instance.signInWithCredential(credential);
// //   }
// // }
