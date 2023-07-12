import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/presentation/screens/morescreen/appointments_list/widget/titles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/const/const.dart';
import '../../../../../widgets/elevated_button_widgets.dart';

class NotificationListDetailsWidget extends StatelessWidget {
  const NotificationListDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                'No Appointments!',
                style: kTextStyleMediumBlack,
              ),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                final appointmentData =
                    appointments[index].data() as Map<String, dynamic>;
                final name = appointmentData['doctorName'] as String?;
                final categorie = appointmentData['doctorCategory'] as String?;
                final time = appointmentData['appointmentTime'];
                final date = appointmentData['appointmentDate'];

                return Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 161, 184, 162),
                      borderRadius: BorderRadius.circular(10)),
                  height: 170,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                      const Titles(),
                      kHeight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            date,
                            style: kTextStyleMediumBlack,
                          ),
                          Text(
                            time,
                            style: kTextStyleMediumBlack,
                          ),
                          Text(
                            name ?? '',
                            style: kTextStyleMediumBlack,
                          )
                        ],
                      ),
                      kHeight10,
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      const TitlesTwo(),
                      Row(
                        children: [
                          Text(
                            categorie!,
                            style: kTextStyleMediumBlack,
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          Text(
                            'kannur',
                            style: kTextStyleMediumBlack,
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          SizedBox(
                              width: 80,
                              child: ElevatedButtons(
                                  text: 'Cancel', onPressed: () {}))
                        ],
                      )
                    ]),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 15),
              itemCount: appointments.length);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
