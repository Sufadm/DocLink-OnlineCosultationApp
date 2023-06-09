import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signInAnonym() async {
  try {
    UserCredential result = await FirebaseAuth.instance.signInAnonymously();
    return result;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
