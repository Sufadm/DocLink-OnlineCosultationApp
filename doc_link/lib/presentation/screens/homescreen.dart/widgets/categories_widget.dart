import 'package:flutter/material.dart';

import '../../../../shared/const/const.dart';

class CategoriesWidget extends StatelessWidget {
  final String categories;
  final VoidCallback ontap;
  const CategoriesWidget({
    super.key,
    required this.categories,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth * 0.35;
    final double containerHeight = containerWidth * 0.6;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: kLightBlueColor),
        height: containerHeight,
        width: containerWidth,
        child: Center(
            child: Text(
          categories,
          style: kTextStyleMediumWhite,
        )),
      ),
    );
  }
}
