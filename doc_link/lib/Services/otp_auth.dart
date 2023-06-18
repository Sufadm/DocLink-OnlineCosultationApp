import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/loginscreen/otpscreen.dart';

class AuthenticationService {
  static void sendPhoneNumber(String phoneNumber, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OtpScreen(verificationId: phoneAuthCredential.smsCode ?? '');
          }));
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OtpScreen(verificationId: verificationId);
          }));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 60),
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }
}
