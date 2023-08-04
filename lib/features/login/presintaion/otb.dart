import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneSignInScreen extends StatefulWidget {
  @override
  _PhoneSignInScreenState createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  String _smsCode = '';
  final TextEditingController _phoneFiledController = TextEditingController();
  String countryCode = "+20";

  Future<void> _verifyPhoneNumber() async {
    try {
      print("---------------------------------------------------");
      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential phoneAuthCredential) {
        _auth.signInWithCredential(phoneAuthCredential);
      };

      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException authException) {
        print('Phone number verification failed: ${authException.message}');
      };

      final PhoneCodeSent codeSent =
          (String verificationId, [int? forceResendingToken]) async {
        _verificationId = verificationId;
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        _verificationId = verificationId;
      };

      await _auth.verifyPhoneNumber(
        phoneNumber: '+201273793869', // Replace with the user's phone number
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print("=============================${e.toString()}");
    }
  }

  Future<void> _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsCode,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    final User user = authResult.user!;
    print('User signed in: ${user.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: ListView(

        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height*.5,child: SvgPicture.asset("assets/mobile-auth-pic.svg")),

          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntlPhoneField(
                controller: _phoneFiledController,
                initialCountryCode: "EG",
                onCountryChanged: (value) {
                  countryCode = value.dialCode;
                },
                showDropdownIcon: false, // Hide the country dropdown icon
                showCountryFlag: true, // Hide the country flag
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your phone number",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              )),
          ElevatedButton(
            onPressed: _verifyPhoneNumber,
            child: Text('Verify Phone Number'),
          ),
          SizedBox(height: 16),
          // TextField(
          //   onChanged: (value) {
          //     _smsCode = value;
          //   },
          //   decoration: InputDecoration(
          //     labelText: 'Enter SMS Code',
          //   ),
          // ),
          // SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: _signInWithPhoneNumber,
          //   child: Text('Sign In'),
          // ),
        ],
      ),
    );
  }
}
