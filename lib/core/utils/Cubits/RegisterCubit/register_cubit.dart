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
        print("================================================");
        GoRouter.of(context).push(AppRouter.kvirtfienum);

        emit(Success());
      }

      codeSent(String verificationId, [int? forceResendingToken]) {
        _verificationId = verificationId;
        GoRouter.of(context).push(AppRouter.kvirtfienum);
        emit(Success());
      }

      codeAutoRetrievalTimeout(String verificationId) {
        _verificationId = verificationId;
        showToastMessage("code Timeout", Colors.red);
        emit(Error("code Timeout"));
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
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
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

          
      final customToken = await authResult.user!.getIdToken();
      box.put('customToken', customToken);

      final storedCustomToken = box.get('customToken');

      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> autoLogin(context) async {
    emit(Waitting());

    try {
      final storedCustomToken = box.get('customToken');
      if (storedCustomToken != null) {
        // Sign in with the custom token
        try {
          await _auth.signInWithCustomToken(storedCustomToken);
          // ignore: empty_catches
        } catch (e) {}
        GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
      }
      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
