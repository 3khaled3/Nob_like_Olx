import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  Future<void> verifyPhoneNumber(phoneNumber) async {
    emit(Waitting());
    try {
      print("---------------------------------------------------");
      verificationCompleted(AuthCredential phoneAuthCredential) {
        _auth.signInWithCredential(phoneAuthCredential);
        emit(Success());
      }

      verificationFailed(FirebaseAuthException authException) {
        print('Phone number verification failed: ${authException.message}');
      }

      codeSent(String verificationId, [int? forceResendingToken]) async {
        _verificationId = verificationId;
        
      }

      codeAutoRetrievalTimeout(String verificationId) {
        _verificationId = verificationId;
        emit(Error("code Timeout"));
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber, // Replace with the user's phone number
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
      
    } catch (e) {
      emit(Error(e.toString()));
      print("=============================${e.toString()}");
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

      final User user = authResult.user!;
      print('User signed in: ${user.uid}');
      emit(Success());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
