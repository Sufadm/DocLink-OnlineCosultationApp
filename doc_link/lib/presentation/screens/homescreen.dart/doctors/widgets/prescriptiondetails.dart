import 'package:doc_link/widgets/custom_appbar_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../../model/prescription_model.dart';
import '../../../../../shared/const/const.dart';

class PrescriptionDetailsScreen extends StatelessWidget {
  final PrescriptionModel prescription;

  const PrescriptionDetailsScreen({Key? key, required this.prescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Prescription Details'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            kHeight25,
            Container(
              height: 200,
              width: double.infinity,
              color: greylight1,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drug:   ${prescription.drug}',
                      style: kTextStyleMediumBlack,
                    ),
                    kHeight10,
                    Text(
                      'Usage:   ${prescription.usageDuration}',
                      style: kTextStyleMediumBlack,
                    ),
                    kHeight10,
                    Text(
                      'Duration:   ${prescription.duration}',
                      style: kTextStyleMediumBlack,
                    ),
                    kHeight10,
                    Text(
                      'Remarks:   ${prescription.remarks}',
                      style: kTextStyleMediumBlack,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
