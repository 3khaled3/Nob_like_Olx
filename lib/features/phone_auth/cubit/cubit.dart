// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
// import 'package:bloc/bloc.dart';
// // import 'package:chat_app/app/di.dart';
// // import 'package:chat_app/domain/repository/notification_repo.dart';
// import 'package:flutter/services.dart';
// import 'package:nob/features/phone_auth/cubit/states.dart';
// import 'package:dartz/dartz.dart';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:dartz/dartz.dart';


// UserModel? appUserModel;
// String? UID;

// class Constants {
//   static const String empty = "";
//   static const int minusOne = -1;
//   static const int zero = 0;
//   static const String defaultUserImage =
//       "https://firebasestorage.googleapis.com/v0/b/chat-app-a863d.appspot.com/o/images%2FdefualtUserImage%2Fdefault-user-image.png?alt=media&token=eefe9301-091f-4525-a719-254b3247c26e";

//   static const String appAPIKey =
//       'AAAAQTZi-as:APA91bHmoGqtOqpjB9yLvglqOf0sEh6NIoEbYe7yOhQ96N20tL6vm_-zNTkpXxFc1phcAV590xbHsljH_rCObzhm5nhYauGPMMsSyemvDZo2zlROrEgmTbgI5zWdohhpfJm5VJfTDUAP';

//   static const String baseUrl = 'https://fcm.googleapis.com/fcm/send';
// }
// class PhoneAuthCubit extends Cubit<PhoneAuthStates> {
//   final AuthRepository _authRepository = instance<AuthRepository>();
//   final AppPreferences _appPreferences = instance<AppPreferences>();
//   final _notificationRepo = instance<NotificationRepo>();
//   PhoneAuthCubit() : super(PhoneAuthInitialSates());
//   String? _verificationId;
//   String? phoneNumber;
//   String? code;
//   bool isExists = false;

//   Future<void> sendVerificationCode(
//       {required String phoneNumber, required Function codeCent}) async {
//     emit(SendCodeLoadingState());
//     (await _authRepository.sendVerificationCode(
//             phoneNumber: phoneNumber,
//             codeCent: (verificationId, p1) async {
//               codeCent();
//               _verificationId = verificationId;
//               this.phoneNumber = phoneNumber;
//               emit(SendCodeSuccessState());
//               emit(VerificationStates());
//               await initSmsListener();
//             }))
//         .fold((failure) {
//       emit(SendCodeErrorState(failure.message));
//     }, (r) {});
//   }

//   signIn(
//       {required String smsCode,
//       required Function onVerifiedSuccessfully}) async {
//     if (_verificationId != null) {
//       emit(VerifyCodeLoadingState());
//       (await _authRepository.signInWithCredential(_verificationId!, smsCode))
//           .fold((failure) {
//         emit(VerifyCodeErrorState(failure.message));
//       }, (uid) async {
//         await _afterSignIn(uid);
//         onVerifiedSuccessfully.call();
//         emit(VerifyCodeSuccessState());
//       });
//     }
//   }

//   _afterSignIn(String uid) async {
//     await _appPreferences.setUserUid(uid);
//     await _isUserExists(uid);
//     if (!isExists) {
//       await _appPreferences.setUserPhoneNumber(phoneNumber!);
//     }else{
//       await _appPreferences.setUserRegistered();
//     }
//     UID = uid;
//   }

//   _isUserExists(String uid) async {
//     (await _authRepository.isUserAlreadyExists(uid)).fold((failure) {
//       emit(VerifyCodeErrorState(failure.message));
//     }, (exists) {
//       print(exists);
//       isExists = exists;
//     });
//   }

//     Future<String> getToken() async {
//     String token = "";
//     (await _notificationRepo.getDeviceToken()).fold((failure) {},
//         (deviceToken) {
//       token = deviceToken;
//     });
//     return token;
//   }

//   Future<void> initSmsListener() async {
//     try {
//       code = await AltSmsAutofill().listenForSms;
//     } on PlatformException {
//       code = null;
//     }
//     emit(VerificationStates());
//     AltSmsAutofill().unregisterListener();
//   }

//   @override
//   Future<void> close() async {
//    // super.close();
//   }
// }


// abstract class AuthRepository {
//   Future<Either<Failure, void>> sendVerificationCode({
//     required String phoneNumber,
//     required Function(String , int?) codeCent,
//   });

//   Future<Either<Failure, String>> signInWithCredential(String verificationId , String smsCode);

//   Future<Either<Failure, bool>> isUserAlreadyExists(String uid);
// }class Failure{
//   String message; // error , success
//   Failure(this.message);
// }

// const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
//     "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
// const String PREFS_KEY_USER_UID = "PREFS_KEY_USER_UID";
// const String PREFS_KEY_USER_PHONE_NUMBER = "PREFS_KEY_USER_PHONE_NUMBER";
// const String PREFS_KEY_IS_USER_NAME = "PREFS_KEY_IS_USER_NAME";
// const String PREFS_KEY_IS_USER_REGISTERED = "PREFS_KEY_IS_USER_REGISTERED";
// const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
// const String PREFS_KEY_DEVICE_TOKEN = "PREFS_KEY_DEVICE_TOKEN";

// class AppPreferences {
//   final SharedPreferences _sharedPreferences;
//   AppPreferences(this._sharedPreferences);

//   Future<void> setOnBoardingScreenViewed() async {
//     await _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
//   }

//   bool isOnBoardingScreenViewed() {
//     return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
//         false;
//   }

//   Future<void> setUserUid(String uid) async {
//     await _sharedPreferences.setString(PREFS_KEY_USER_UID, uid);
//   }

//   String? getUserUid() {
//     return _sharedPreferences.getString(PREFS_KEY_USER_UID);
//   }

//   Future<void> setUserPhoneNumber(String phoneNumber) async {
//     await _sharedPreferences.setString(
//         PREFS_KEY_USER_PHONE_NUMBER, phoneNumber);
//   }

//   String? getUserPhoneNumber() {
//     return _sharedPreferences.getString(PREFS_KEY_USER_PHONE_NUMBER);
//   }

//   Future<void> setUserRegistered() async {
//     await _sharedPreferences.setBool(PREFS_KEY_IS_USER_REGISTERED, true);
//   }

//   bool isUserRegistered() {
//     return _sharedPreferences.getBool(PREFS_KEY_IS_USER_REGISTERED) ?? false;
//   }

//   Future<void> deletePhoneNumber() async {
//     await _sharedPreferences.remove(PREFS_KEY_USER_PHONE_NUMBER);
//   }

//   Future<void> logOut() async {
//     await _sharedPreferences.remove(PREFS_KEY_USER_UID);
//     await _sharedPreferences.setBool(PREFS_KEY_IS_USER_REGISTERED, false);
//   }

//   Future<String> getAppLanguage() async {
//     String? language = await _sharedPreferences.getString(PREFS_KEY_LANG);

//     if (language != null) {
//       return language;
//     } else {
//       return LanguageType.ENGLISH.getValue();
//     }
//   }

//   Future<void> changeAppLanguage() async {
//     String currentLanguage = await getAppLanguage();

//     if (currentLanguage == LanguageType.ARABIC.getValue()) {
//       await _sharedPreferences.setString(
//           PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
//     } else {
//       await _sharedPreferences.setString(
//           PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
//     }
//   }

//   Future<Locale> getLocale() async {
//     String currentLanguage = await getAppLanguage();
//     if (currentLanguage == LanguageType.ARABIC.getValue()) {
//       return ARABIC_LOCAL;
//     } else {
//       return ENGLISH_LOCAL;
//     }
//   }

//   Future<void> setDeviceToken(String token) async {
//     await _sharedPreferences.setString(PREFS_KEY_DEVICE_TOKEN, token);
//   }

//   String getDeviceToken() {
//     return _sharedPreferences.getString(PREFS_KEY_DEVICE_TOKEN) ??
//         Constants.empty;
//   }
// }

// enum LanguageType { ENGLISH, ARABIC }
// const String ARABIC = "ar";
// const String ENGLISH = "en";

// const String ASSET_PATH_LOCALIZATION = "assets/translations";

// const Locale ARABIC_LOCAL = Locale("ar" , 'SA');
// const Locale ENGLISH_LOCAL = Locale("en" , 'US');


// extension LanguageTypeExtension on LanguageType{
//  String getValue() {
//   switch (this) {
//    case LanguageType.ARABIC:
//     return ARABIC;
//    case LanguageType.ENGLISH:
//     return ENGLISH;
//   }
//  }
// }


// abstract class NotificationRepo {
//   Future<Either<Failure, void>> sendNotification(
//       UserModel userModel, String body, String title);

//   Future<Either<Failure, String>> getDeviceToken();
// }
// class UserModel {
//   String uid;
//   String status;
//   String username;
//   String phoneNumber;
//   String nickName;
//   String imageLink;
//   String bio;
//   String deviceToken;
//   String userDeviceLang;

//   UserModel(this.uid, this.status, this.username, this.phoneNumber,
//       this.nickName, this.imageLink, this.bio, this.deviceToken , this.userDeviceLang);


//   bool isEqual(UserModel userModel){
//     if(uid == userModel.uid){
//       return true;
//     }else{
//       return false;
//     }
//   }    
// }

// class MessageModel {
//   String message;
//   String senderUID;
//   String senderName;
//   String receiverUID;
//   String dateTime;
//   bool isError;

//   MessageModel(this.message, this.senderUID,this.senderName,this.receiverUID, this.dateTime,
//       {this.isError = false});

//   set error(bool isError) {
//     this.isError = isError;
//   }
// }

// class ChatModel {
//   String senderUser;
//   String receiverUser;
//   String lastMessage;
//   String lastMessageTime;
//   int unreadMessages;
//   MessageModel? messageModel;

//   ChatModel(this.senderUser, this.receiverUser, this.lastMessage,
//       this.lastMessageTime, this.unreadMessages,
//       {this.messageModel});
// }

// class GroupChatModel {
//   String groupName;
//   String groupImage;
//   String uid;
//   Map<String , int> groupMembers;
//   String lastSender;
//   String lastMessageTime;
//   String lastMessage;

//   GroupChatModel(this.uid , this.groupName, this.groupImage, this.groupMembers ,this.lastSender,
//       this.lastMessageTime,this.lastMessage);
// }
