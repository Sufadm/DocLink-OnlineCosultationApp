import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitlesTwo extends StatelessWidget {
  const TitlesTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [],
    );
  }
}

class Titles extends StatelessWidget {
  const Titles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Date',
          style: GoogleFonts.lato(),
        ),
        SizedBox(
          width: 60,
          child: Text(
            'Time',
            style: GoogleFonts.lato(),
          ),
        ),
        Text(
          'Doctor',
          style: GoogleFonts.lato(),
        )
      ],
    );
  }
}
