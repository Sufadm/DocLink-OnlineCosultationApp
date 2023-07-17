import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../shared/const/const.dart';
import '../appointment_details.dart';

class NotificationListDetailsWidget extends StatelessWidget {
  const NotificationListDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    User? currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('userId', isEqualTo: currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<QueryDocumentSnapshot> appointments =
              snapshot.data!.docs.cast<QueryDocumentSnapshot>();
          if (appointments.isEmpty) {
            return Center(
              child: Lottie.network(
                'https://lottie.host/77d12cca-195a-4372-9da8-85380b6d8a3f/LFqyLxLC4M.json',
                //style: kTextStyleMediumBlack,
              ),
            );
          }
          final groupedAppointments = groupAppointmentsByUser(appointments);

          return ListView.builder(
            itemBuilder: (context, index) {
              final appointmentGroup = groupedAppointments[index];
              final name = appointmentGroup[0]['doctorName'] as String?;
              final category = appointmentGroup[0]['doctorCategory'] as String?;
              final date = appointmentGroup[0]['appointmentDate'];

              final image = appointmentGroup[0]['doctorImage'];
              final appointmentCount = appointmentGroup.length;

              return Card(
                color: kWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, // Adjust the vertical padding as desired
                    horizontal: 12,
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    radius: screenWidth * 0.057,
                  ),
                  // title:
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name ?? '',
                            style: GoogleFonts.outfit(
                                color: kBlackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            category ?? '',
                            style: GoogleFonts.outfit(color: kBlackColor),
                          ),
                        ],
                      ),
                      Text(
                        date,
                        style: GoogleFonts.outfit(color: kBlackColor),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 7),
                        child: CircleAvatar(
                          foregroundColor: kBlackColor,
                          radius: screenWidth * 0.045,
                          child: Text(
                            '$appointmentCount',
                            style: GoogleFonts.outfit(),
                          ),
                        ),
                      )
                    ],
                  ),
                  // Add onTap functionality if required
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AppointmentDetails(
                        times: appointmentGroup
                            .map((appointment) =>
                                appointment['appointmentTime'] as String)
                            .toList(),
                        names: appointmentGroup
                            .map((appointment) =>
                                appointment['doctorName'] as String)
                            .toList(),
                        images: appointmentGroup
                            .map((appointment) =>
                                appointment['doctorImage'] as String)
                            .toList(),
                      );
                    }));
                  },
                ),
              );
            },
            itemCount: groupedAppointments.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  List<List<QueryDocumentSnapshot>> groupAppointmentsByUser(
    List<QueryDocumentSnapshot> appointments,
  ) {
    final Map<String, List<QueryDocumentSnapshot>> groupedMap = {};

    for (final appointment in appointments) {
      final doctorId = appointment['doctorId'];

      if (groupedMap.containsKey(doctorId)) {
        groupedMap[doctorId]!.add(appointment);
      } else {
        groupedMap[doctorId] = [appointment];
      }
    }

    return groupedMap.values.toList();
  }
}
