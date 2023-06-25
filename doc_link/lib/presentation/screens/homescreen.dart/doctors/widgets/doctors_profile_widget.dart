import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../model/profile_model.dart';
import '../../../../../shared/const/const.dart';

class DoctorsProfileWidget extends StatelessWidget {
  final ProfileModel profile;

  const DoctorsProfileWidget({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 140,
          width: 140,
          child: Image.network(
            profile.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
            height: 140,
            width: 130,
            // color: Colors.amberAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  profile.name,
                  style: kTextStyleMediumBlack,
                ),
                Text(
                  profile.category,
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 129, 129, 129)),
                ),
                Text(
                  profile.qualification,
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 129, 129, 129)),
                ),
              ],
            )),
      ],
    );
  }
}
