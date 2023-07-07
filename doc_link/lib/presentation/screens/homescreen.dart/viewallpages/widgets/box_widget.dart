import 'package:doc_link/shared/const/const.dart';
import 'package:flutter/material.dart';

class ViewAllCategorieWidget extends StatelessWidget {
  final String categoriename;
  final VoidCallback ontap;
  const ViewAllCategorieWidget({
    super.key,
    required this.categoriename,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kWhiteColor),
        height: 60,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person),
              Text(
                categoriename,
                style: kTextStyleMediumBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
