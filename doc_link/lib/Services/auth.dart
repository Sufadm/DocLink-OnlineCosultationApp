// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../model/model.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   UserModel? _userFromCredential(User? user) {
//     return user != null ? UserModel(uid: user.uid) : null;
//   }

//   Stream<UserModel?> get userlog {
//     return _auth
//         .authStateChanges()
//         .map((User? user) => _userFromCredential(user));
//   }

//   //Google Sign In
//   signInWithGoogle() async {
//     //begin interactive sign in process
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     //obtain auth details from request
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;

//     //create a new credential for user
//     final credential = GoogleAuthProvider.credential(
//         accessToken: gAuth.accessToken, idToken: gAuth.idToken);

//     //finally, lets sign in
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   //sign out

//   Future logout() async {
//     try {
//       return await _auth.signOut();
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }
