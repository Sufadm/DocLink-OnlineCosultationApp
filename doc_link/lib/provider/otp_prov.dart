// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../presentation/screens/bottomnav/bottomnav.dart';

// class OtpScreenProvider extends ChangeNotifier {
//   late String _verificationId;
//   String? _errorMessage;

//   String? get errorMessage => _errorMessage;

//   void verifyOtp(
//       {required BuildContext context, required String userOtp}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;

//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: userOtp,
//       );
//       await auth.signInWithCredential(credential);
//       // ignore: use_build_context_synchronously
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) {
//           return const BottomNav();
//         }),
//       );
//     } on FirebaseAuthException {
//       _errorMessage = 'Error verifying OTP. Please enter it correctly!';
//       notifyListeners();
//     }
//   }
// }
