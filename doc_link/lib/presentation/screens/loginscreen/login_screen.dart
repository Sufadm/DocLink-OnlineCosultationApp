import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/loginscreen/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight10,
              Row(
                children: [
                  kWidth10,
                  Text(
                    'LOGIN',
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 1, 43, 114)),
                  ),
                ],
              ),
              kHeight10,
              //Image section
              SizedBox(
                height: 320,
                width: double.infinity,
                child: Image.asset(
                  'asset_images/a-patient-consults-a-doctor-and-nurse-free-vector.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              //image section end
              kHeight15,
              Text('Enter The Mobile Number',
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              kHeight10,
              TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  )),
              Text(
                'We will send you a one time password to this mobile number',
                style: GoogleFonts.lato(),
              ),
              const SizedBox(
                height: 7,
              ),
              //Button widget---------------------------------------------------
              const ElevatedButtons(
                text: 'Send OTP',
              ),
            ],
          ),
        ),
      ),
    );
  }
}