import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/model/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfileService {
  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('userprofile');
//?upload user profile image----------------------------------------------------
  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('usersProfile/$filename');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      // Handle the error appropriately
      rethrow;
    }
  }

//?adding values of profile-----------------------------------------------------
  Future<void> getUserProfile(UserProfileModel user) async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('userprofile').doc(user.uid);
      user.uid = docUser.id;
      final json = user.toJson();
      await docUser.set(json);
    } catch (error) {
      rethrow;
    }
  }

//? Get User profile values-----------------------------------------------------

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAllUserProfile() {
    final currentUserId =
        getCurrentUserId(); // Replace with your logic to get the currently logged-in user's ID
    final profileStream = FirebaseFirestore.instance
        .collection('userprofile')
        .doc(currentUserId)
        .snapshots();
    return profileStream;
  }

  String getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  Future<void> deleteUserProfile(UserProfileModel user) async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('userprofile').doc(user.uid);
      await docUser.delete();
    } catch (error) {
      rethrow;
    }
  }
}
