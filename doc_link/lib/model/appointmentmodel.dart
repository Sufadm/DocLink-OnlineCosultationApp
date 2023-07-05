// class AppointmentDtaModel {
//   final String userId;
//   final String doctorId;
//   final String doctorName;
//   final String doctorCategory;
//   final DateTime appointmentDate;
//   final String remarks;

//   AppointmentDtaModel({
//     required this.userId,
//     required this.doctorId,
//     required this.doctorName,
//     required this.doctorCategory,
//     required this.appointmentDate,
//     required this.remarks,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'doctorId': doctorId,
//       'doctorName': doctorName,
//       'doctorCategory': doctorCategory,
//       'appointmentDate': appointmentDate,
//       'remarks': remarks,
//     };
//   }

//   factory AppointmentDtaModel.fromMap(Map<String, dynamic> map) {
//     return AppointmentDtaModel(
//       userId: map['userId'],
//       doctorId: map['doctorId'],
//       doctorName: map['doctorName'],
//       doctorCategory: map['doctorCategory'],
//       appointmentDate: map['appointmentDate'].toDate(),
//       remarks: map['remarks'],
//     );
//   }
// }
