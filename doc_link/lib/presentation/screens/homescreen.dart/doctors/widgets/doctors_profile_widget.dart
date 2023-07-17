import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../model/doctor_profile_model.dart';
import '../../../../../shared/const/const.dart';

class DoctorsProfileWidget extends StatelessWidget {
  final ProfileModel profile;

  const DoctorsProfileWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          // height:150
          height: screenWidth * 0.369,
          width: screenWidth * 0.362,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10), // Set the desired border radius
              image: DecorationImage(
                image: NetworkImage(profile.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight / 3,
          width: screenWidth / 3.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                profile.name,
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                profile.category,
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold, color: kBlackColor),
              ),
              Text(
                profile.qualification,
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold, color: kBlackColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
