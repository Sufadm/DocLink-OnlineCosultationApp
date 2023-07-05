import 'package:doc_link/presentation/screens/homescreen.dart/doctors/widgets/prescriptiondetails.dart';
import 'package:doc_link/services/firestore_service.dart';
import 'package:flutter/material.dart';

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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: greylight1,
                  ),
                  height: 70,
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prescription ${index + 1}',
                          style: kTextStyleMediumBlack,
                        ),
                        const Icon(Icons.east)
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
