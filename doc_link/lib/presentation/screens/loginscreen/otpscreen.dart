import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/profilescreen/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import '../../../widgets/elevated_button_widgets.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'OTP Verification',
                  style: GoogleFonts.lato(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 1, 43, 114)),
                ),
              ),
              kHeight20,
              SizedBox(
                height: 270,
                width: double.infinity,
                child: Image.asset(
                  'asset_images/e9b33ec8595630e5a2cfaa14eb6784b6.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              kHeight10,
              Center(
                  child: Text(
                'We have send to you a one time password',
                style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 124, 121, 121),
                    fontWeight: FontWeight.bold),
              )),
              Center(
                  child: Text(
                '*******770',
                style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 124, 121, 121),
                    fontWeight: FontWeight.bold),
              )),
              kHeight15,
              SingleChildScrollView(
                //? type OTP-
                child: OtpPinField(
                  onSubmit: (text) {
                    // print('Entered pin is $text');

                    /// return the entered pin
                  },
                  onChange: (text) {
                    //  print('Enter on change pin is $text');

                    /// return the entered pin
                  },
                  textInputAction: TextInputAction.done,
                  otpPinFieldStyle: const OtpPinFieldStyle(
                    defaultFieldBorderColor: Color.fromARGB(255, 0, 27, 177),
                  ),
                  maxLength: 5,
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),
              ),
              kHeight10,
              Container(
                margin: const EdgeInsets.only(left: 160),
                child: Text(
                  'Please wait for 60 to Resend OTP',
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 175, 175, 175),
                      fontWeight: FontWeight.bold),
                ),
              ),
              kHeight10,
              ElevatedButtons(
                text: 'SUBMIT',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProfileScreen();
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
