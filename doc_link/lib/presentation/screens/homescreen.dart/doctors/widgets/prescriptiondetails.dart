import 'package:doc_link/core/custom_appbar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../model/prescription_model.dart';
import '../../../../../shared/const/const.dart';

class PrescriptionDetailsScreen extends StatelessWidget {
  final PrescriptionModel prescription;

  const PrescriptionDetailsScreen({Key? key, required this.prescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(text: 'Prescription Details'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            kHeight10,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor,
              ),
              // height: 150,
              height: screenHeight / 2.7,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drug:   ${prescription.drug}',
                      style: GoogleFonts.outfit(fontSize: 15),
                    ),
                    kHeight5,
                    Text(
                      'Usage:   ${prescription.usageDuration}',
                      style: GoogleFonts.outfit(fontSize: 15),
                    ),
                    kHeight5,
                    Text(
                      'Duration:   ${prescription.duration}',
                      style: GoogleFonts.outfit(fontSize: 15),
                    ),
                    kHeight5,
                    Text(
                      'Remarks:   ${prescription.remarks}',
                      style: GoogleFonts.outfit(fontSize: 15),
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
