import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/model/add_details_model.dart';

import '../model/doctor_profile_model.dart';

class FirestoreService {
  //?get doctors details--------------------------------------------------------
  Stream<List<ProfileModel>> getDoctorsProfilesStream() {
    final doctorCollection =
        FirebaseFirestore.instance.collection('doctorsprofile');
    return doctorCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProfileModel.fromJson(doc.data())).toList());
  }

//?Add details Stream-----------------------------------------------------------
  Stream<List<AddDetailModel>> getAllDetailsDoctors() {
    final doctorCollection =
        FirebaseFirestore.instance.collection('adddetails');
    return doctorCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => AddDetailModel.fromJson(doc.data()))
        .toList());
  }
}
