import 'package:flutter/material.dart';

import '../../../../../../const/const.dart';

class DoctorsListWidget extends StatelessWidget {
  final String doctorname;
  final VoidCallback? onTap;
  const DoctorsListWidget({
    super.key,
    required this.doctorname,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              const CircleAvatar(
                maxRadius: 30,
                minRadius: 10,
              ),
              Text(
                doctorname,
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
