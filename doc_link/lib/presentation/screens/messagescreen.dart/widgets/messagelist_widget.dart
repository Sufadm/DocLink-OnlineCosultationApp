import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/presentation/screens/messagescreen.dart/chattingscreen/chattingscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/const/const.dart';

class MessageListDoctors extends StatelessWidget {
  const MessageListDoctors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return Center(
                child: Text(
              'No Messages',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ));
          }
          final uniqueDoctorIds = <String>{};

          return Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index].data();
                final doctorId = document['doctorId'] as String;
                final name = document['doctorName'] as String;
                final image = document['doctorImage'] as String;
                final category = document['doctorCategory'] as String;

                if (uniqueDoctorIds.contains(doctorId)) {
                  return const SizedBox.shrink();
                }
                uniqueDoctorIds.add(doctorId);

                return Container(
                  color: kWhiteColor,
                  child: ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChattingScreen(
                        doctorId: doctorId,
                        categorie: category,
                        name: name,
                        image: image,
                      );
                    })),
                    subtitle: Text(
                      category,
                      style: GoogleFonts.outfit(),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: CircleAvatar(
                      maxRadius: 25,
                      // minRadius: 10,
                      backgroundImage: NetworkImage(image),
                    ),
                    title: Text(
                      name,
                      style: kTextStyleMediumBlack,
                    ),
                    trailing: const Icon(Icons.east),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
