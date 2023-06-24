import 'package:flutter/material.dart';

import '../../../../../../shared/const/const.dart';

class DoctorsListWidget extends StatelessWidget {
  final String doctorname;
  final VoidCallback? onTap;
  final String avatarImageUrl;
  const DoctorsListWidget({
    super.key,
    required this.doctorname,
    this.onTap,
    required this.avatarImageUrl,
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
              CircleAvatar(
                maxRadius: 30,
                minRadius: 10,
                backgroundImage: NetworkImage(avatarImageUrl),
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
