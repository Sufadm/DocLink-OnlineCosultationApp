import 'package:doc_link/presentation/screens/homescreen.dart/doctors/widgets/prescriptiondetails.dart';
import 'package:doc_link/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../model/prescription_model.dart';
import '../../../../../shared/const/const.dart';

class PrescriptionListWidget extends StatelessWidget {
  final String userid;
  const PrescriptionListWidget({
    Key? key,
    required this.userid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PrescriptionModel>>(
      stream: FirestoreService().getAllPrescriptions(userid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final prescriptionList = snapshot.data!;
          if (prescriptionList.isEmpty) {
            return Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                ' No Records/',
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
            );
          }
          return ListView.separated(
            itemCount: prescriptionList.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
            ),
            itemBuilder: (context, index) {
              final prescription = prescriptionList[index];
              return GestureDetector(
                  onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PrescriptionDetailsScreen(
                          prescription: prescription,
                        );
                      })),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              prescription.date!,
                              style:
                                  GoogleFonts.lato(fontWeight: FontWeight.bold),
                            ),
                            kWidth10,
                            const Expanded(
                              child: Divider(
                                endIndent: 5,
                                thickness: 0.2,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      kHeight5,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kWhiteColor),
                        height: 57,
                        width: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' Prescription ${index + 1}',
                                style: GoogleFonts.outfit(
                                    color: kBlackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.east,
                                color: kBlackColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
