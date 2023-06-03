import 'package:flutter/material.dart';

import '../../../../../const/const.dart';

class PrescriptionListWidget extends StatelessWidget {
  final String prescriptionName;
  const PrescriptionListWidget({
    super.key,
    required this.prescriptionName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                prescriptionName,
                style: kTextStyleMediumBlack,
              ),
              const Icon(Icons.east)
            ],
          ),
        ),
      ),
    );
  }
}
