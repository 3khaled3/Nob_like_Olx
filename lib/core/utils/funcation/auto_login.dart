import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../routes.dart';

Future<void> autoLogin(context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var box = Hive.box('myBox');
  try {
    final storedCustomToken = box.get('customToken');
    if (storedCustomToken != null) {
      // Sign in with the custom token
      try {
        await _auth.signInWithCustomToken(storedCustomToken);

        // ignore: empty_catches
      } catch (e) {}
      GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
    } else {
      await Future.delayed(const Duration(seconds: 3));

      GoRouter.of(context).pushReplacement(AppRouter.kPhoneSignInScreen);
    }
  } catch (e) {}
}
