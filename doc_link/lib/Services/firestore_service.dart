import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/profile_model.dart';

class FirestoreService {
  Stream<List<ProfileModel>> getDoctorsProfilesStream() {
    final doctorCollection =
        FirebaseFirestore.instance.collection('doctorsprofile');
    return doctorCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProfileModel.fromJson(doc.data())).toList());
  }
}
