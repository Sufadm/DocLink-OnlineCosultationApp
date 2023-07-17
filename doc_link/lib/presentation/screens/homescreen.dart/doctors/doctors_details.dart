import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/widgets/doctors_profile_widget.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/widgets/prescriptionlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/doctor_profile_model.dart';
import 'appointmentpage/appointment_page.dart';

class DoctorsDetails extends StatelessWidget {
  final ProfileModel profile;

  const DoctorsDetails({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight10,
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(
              height: 10,
            ),
            //?Doctors profile--------------------------------------------------
            DoctorsProfileWidget(
              profile: profile,
            ),
            kHeight25,
            Container(
              margin: const EdgeInsets.only(
                left: 80,
                right: 115,
              ),
            ),
            kHeight25,
            const Divider(
              color: Colors.black,
              height: 1,
            ),
            //?prescription List------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Prescriptions',
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //?prescriptionnList--------------------------------------------
                child: PrescriptionListWidget(userid: profile.uid!),
              ),
            ),

            //?Submit Button--------
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kDarkBlueButtonsColor)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AppointmantPage(
                        profile: profile,
                      );
                    }));
                  },
                  child: Text(
                    'Book an Appointmnet',
                    style: GoogleFonts.outfit(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
