import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/const/const.dart';

class MessageListDoctors extends StatelessWidget {
  const MessageListDoctors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: greylight1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    children: [
                      Text(
                        'Dr. Sufad M',
                        style: kTextStyleLargeBlack,
                      ),
                      Text(
                        'MBBS',
                        style: GoogleFonts.lato(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
