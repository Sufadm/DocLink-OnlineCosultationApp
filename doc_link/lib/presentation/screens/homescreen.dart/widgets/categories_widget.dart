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
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: kLightBlueColor),
        height: 80,
        width: 147,
        child: Center(
            child: Text(
          categories,
          style: kTextStyleMediumWhite,
        )),
      ),
    );
  }
}
