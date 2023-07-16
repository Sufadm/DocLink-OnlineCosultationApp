import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/model/add_details_model.dart';
import 'package:doc_link/services/profile_service.dart';
import 'package:intl/intl.dart';

import '../model/doctor_profile_model.dart';
import '../model/prescription_model.dart';

class FirestoreService {
  //? get doctors values--------------------------------------------------------
  Stream<List<ProfileModel>> getDoctorsProfilesStream() {
    final doctorCollection =
        FirebaseFirestore.instance.collection('doctorsprofile');
    return doctorCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProfileModel.fromJson(doc.data())).toList());
  }

//? get Add details values------------------------------------------------------
  Stream<List<AddDetailModel>> getAllDetailsDoctors() {
    final doctorCollection =
        FirebaseFirestore.instance.collection('adddetails');
    final currentDate = DateTime.now();
    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);

    return doctorCollection
        .where('date', isEqualTo: formattedCurrentDate)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AddDetailModel.fromJson(doc.data()))
            .toList());
  }

//? get prescripions values ----------------------------------------------------
  Stream<List<PrescriptionModel>> getAllPrescriptions(String userId) {
    final prescriptionCollection =
        FirebaseFirestore.instance.collection('precriptions');
    return prescriptionCollection
        .where('userId', isEqualTo: userId)
        .where('id',
            isEqualTo: UserProfileService()
                .getCurrentUserId()) // Add this line to filter by user ID
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PrescriptionModel.fromJson(doc.data()))
            .toList());
  }
}
