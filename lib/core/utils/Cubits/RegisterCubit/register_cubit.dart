// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:nob/core/utils/routes.dart';
import '../../../widget/tossetMassage.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  var box = Hive.box('myBox');

  Future<void> verifyPhoneNumber(phoneNumber, context) async {
    emit(Waitting());
    try {
      verificationCompleted(AuthCredential phoneAuthCredential) {
        _auth.signInWithCredential(phoneAuthCredential);
                   GoRouter.of(context).push(AppRouter.kvirtfienum);

        emit(Success());
      }

      codeSent(String verificationId, [int? forceResendingToken]) async {
        _verificationId = verificationId;
      }

      codeAutoRetrievalTimeout(String verificationId) {
        _verificationId = verificationId;
        showToastMessage("code Timeout", Colors.red);
        emit(Error("code Timeout"));
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber, // Replace with the user's phone number
        verificationCompleted: verificationCompleted,
        verificationFailed: (FirebaseAuthException authException) {
          showToastMessage("${authException.message}", Colors.red);
          emit(Error(
              "Phone number verification failed: ${authException.message}"));
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
      //test
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //     return const OTPScreen();
      //   },
      // ));
      // emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> signInWithPhoneNumber(smsCode) async {
    emit(Waitting());
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      // Store user data in Hive
      box.put('verificationId', _verificationId);
      box.put('sms', smsCode);
      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> autoLogin() async {
    emit(Waitting());

    try {
      final storedsmsCode = box.get('sms');
      final storedverificationId = box.get('verificationId');
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: storedverificationId,
        smsCode: storedsmsCode,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      // Store user data in Hive
      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
