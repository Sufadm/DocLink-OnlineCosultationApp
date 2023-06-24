import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/appointmentpage/appointment_page.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/widgets/doctors_profile_widget.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/widgets/prescriptiondetails.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/widgets/prescriptionlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/profile_model.dart';

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
              height: 50,
            ),
            //?Doctors profile--
            DoctorsProfileWidget(
              profile: profile,
            ),
            kHeight25,
            Container(
              margin: const EdgeInsets.only(
                left: 80,
                right: 115,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 67, 63, 63)),
                  ),
                  Text(
                    "₹ 550/",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: const Color.fromARGB(255, 67, 63, 63)),
                  )
                ],
              ),
            ),
            kHeight25,
            const Divider(
              color: Colors.black,
              height: 1,
            ),
            //?prescription List-----------------
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Prescriptions',
                style: kTextStyleLargeBlack,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: 3, // Specify the number of items in the list
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10), // Add spacing between items
                  itemBuilder: (BuildContext context, int index) {
                    return PrescriptionListWidget(
                      ontap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PrescriptionDetailsScreen();
                      })),
                      prescriptionName: 'Prescription ${index + 1}',
                    );
                  },
                ),
              ),
            ),

            //?Submit Button-
            SizedBox(
              width: 420,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kDarkBlueButtonsColor)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AppointmantPage();
                    }));
                  },
                  child: Text(
                    'Book an Appointmnet',
                    style: GoogleFonts.lato(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
