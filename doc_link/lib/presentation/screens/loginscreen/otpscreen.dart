import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/bottomnav/bottomnav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? _errormessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
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
                kHeight25,
                SingleChildScrollView(
                  //? type OTP------------------------------------
                  child: OtpPinField(
                    onSubmit: (String text) {
                      verifyOtp(context: context, userotp: text);
                    },
                    onChange: (String text) {
                      setState(() {
                        _errormessage = null;
                      });
                    },
                    textInputAction: TextInputAction.done,
                    otpPinFieldStyle: const OtpPinFieldStyle(
                      defaultFieldBorderColor: Color.fromARGB(255, 0, 27, 177),
                    ),
                    maxLength: 6,
                    otpPinFieldDecoration:
                        OtpPinFieldDecoration.defaultPinBoxDecoration,
                  ),
                ),
                kHeight20,
                Center(
                  child: Text(
                    'We have sent you a one-time password',
                    style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 124, 121, 121),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    'to your Number',
                    style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 124, 121, 121),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                kHeight10,
                // Container(
                //   margin: const EdgeInsets.only(left: 160),
                // ),
                kHeight15,
                if (_errormessage != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      _errormessage!,
                      style: GoogleFonts.lato(color: Colors.red),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyOtp(
      {required BuildContext context, required String userotp}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: userotp,
      );
      await auth.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const BottomNav();
        }),
      );
    } on FirebaseAuthException {
      setState(() {
        _errormessage = 'Error verifying OTP Please Enter Correctly! ';
      });
    }
  }
}
