import 'package:flutter/material.dart';
import '../../../../const/const.dart';

class TitleWidget extends StatelessWidget {
  final String titleName;
  final VoidCallback? onTap;
  const TitleWidget({
    super.key,
    required this.titleName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleName,
          style: kTextStyleLarge,
        ),
        Container(
            margin: const EdgeInsets.only(right: 12, top: 7),
            child: GestureDetector(onTap: onTap, child: const Text('View All')))
      ],
    );
  }
}
