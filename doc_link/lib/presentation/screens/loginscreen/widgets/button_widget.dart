import 'package:doc_link/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../otpscreen.dart';

class ElevatedButtons extends StatelessWidget {
  final String text;
  const ElevatedButtons({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 45,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(kDarkBlueButtonsColor)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OtpScreen()),
            );
          },
          child: Text(
            text,
            style: GoogleFonts.lato(),
          )),
    );
  }
}
