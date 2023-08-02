import 'dart:convert';
import 'package:doc_link/services/profile_service.dart';
import 'package:doc_link/shared/const/service_key.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../presentation/screens/homescreen.dart/doctors/appointmentpage/appointment_page.dart';

class NotificationService {
  final UserProfileService userprofileservice = UserProfileService();

  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection("doctorsprofile");

  Future<void> sendNotificationToDoctor(
    String doctorId,
    String userId,
    String doctorFCMToken,
    String userName,
    String time,

    //DateTime date,
    // String time,
  ) async {
    try {
      final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serviceKey',
      };
      final body = {
        'to': doctorFCMToken,
        'notification': {
          'body': '$userName have appointed ',
          'title': 'DocLink'
        },
        'data': {
          'title': "Push Notification",
          'message': 'Test Push Notification',
          'redirect': 'product'
        }
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        // final timestamp = DateTime.now();
        final doctorNotificationRef = userCollectionReference
            .doc(doctorId)
            .collection('doctorNotification')
            .doc();
        final notificationId = doctorNotificationRef.id;
        final appointmentDate = AppointmentDateProvider().getDate();
        final formattedDate = DateFormat('MMMM d').format(appointmentDate!);

// Store the notification data in Firestore
        await doctorNotificationRef.set({
          'doctorId': doctorId,
          'notificationId': notificationId,
          'message': 'you have an appointment by $userName',
          'patientId': userId,
          'date': formattedDate,
          'time': time,
        });
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
