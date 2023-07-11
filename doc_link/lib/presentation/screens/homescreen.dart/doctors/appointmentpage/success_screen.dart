import 'package:doc_link/presentation/screens/bottomnav/bottomnav.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  final String date;
  final String time;
  final String image;
  final String name;
  final String categorie;
  final String paymentId;
  const SuccessScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.categorie,
    required this.date,
    required this.time,
    required this.paymentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 350),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const BottomNav();
                  }));
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            kHeight10,
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 70,
              ),
            ),
            kHeight10,
            Text(
              name,
              style: GoogleFonts.outfit(),
            ),
            Text(
              categorie,
              style: GoogleFonts.outfit(),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhiteColor,
                ),
                height: 130,
                width: double.infinity,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Timing : $time',
                        style: GoogleFonts.outfit(fontSize: 15),
                      ),
                      kHeight5,
                      Text(
                        'Appointment Date: $date  ',
                        style: GoogleFonts.outfit(fontSize: 15),
                      ),
                      kHeight5,
                      Text(
                        'Payment Id:  $paymentId',
                        style: GoogleFonts.outfit(fontSize: 15),
                      ),
                      kHeight5,
                    ],
                  ),
                ),
              ),
            ),
            kHeight15,
            Text(
              'Payment Successfully Completed/',
              style:
                  GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            kHeight10,
            Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_xwmj0hsk.json',
                height: 300)
          ],
        ),
      ),
    );
  }
}
