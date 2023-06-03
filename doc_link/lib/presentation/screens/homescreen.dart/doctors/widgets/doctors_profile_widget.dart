import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../const/const.dart';

class DoctorsProfileWidget extends StatelessWidget {
  const DoctorsProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 130,
          width: 130,
          color: Colors.amberAccent,
          child: Image.network(
            'https://media.istockphoto.com/id/1189304032/photo/doctor-holding-digital-tablet-at-meeting-room.jpg?s=612x612&w=0&k=20&c=RtQn8w_vhzGYbflSa1B5ea9Ji70O8wHpSgGBSh0anUg=',
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
                  'DR SUFAD',
                  style: kTextStyleMediumBlack,
                ),
                Text(
                  'DENTIST',
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 129, 129, 129)),
                ),
                Text(
                  'MBBS',
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 129, 129, 129)),
                ),
              ],
            )),
      ],
    );
  }
}
