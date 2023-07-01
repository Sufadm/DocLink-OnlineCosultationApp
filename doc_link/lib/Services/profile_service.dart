import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/model/user_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfileService {
  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('userprofile');

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

  Stream<List<UserProfileModel>> getAllUserProfile() {
    final doctorCollection =
        FirebaseFirestore.instance.collection('userprofile');
    return doctorCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UserProfileModel.fromJson(doc.data()))
        .toList());
  }
}
