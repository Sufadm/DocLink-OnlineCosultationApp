import 'package:flutter/material.dart';

import '../../../../../shared/const/const.dart';

class PrescriptionListWidget extends StatelessWidget {
  final String prescriptionName;
  final VoidCallback? ontap;
  const PrescriptionListWidget({
    super.key,
    required this.prescriptionName,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
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
