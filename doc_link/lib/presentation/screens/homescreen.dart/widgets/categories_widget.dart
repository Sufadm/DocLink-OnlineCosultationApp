import 'package:flutter/material.dart';

import '../../../../shared/const/const.dart';

class CategoriesWidget extends StatelessWidget {
  final String categories;
  const CategoriesWidget({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
