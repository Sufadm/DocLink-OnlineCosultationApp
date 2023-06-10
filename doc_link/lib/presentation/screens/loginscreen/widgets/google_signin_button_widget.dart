import 'package:doc_link/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSignInButtonWidget extends StatelessWidget {
  const GoogleSignInButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          width: 185.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                kDarkBlueButtonsColor, // Replace with your desired button color
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.network(
                  'https://blog.hubspot.com/hubfs/image8-2.jpg',
                  fit: BoxFit.cover, // Replace with your logo asset path
                  height: 27.0,
                  width: 30.0,
                ),
              ),
              Text('Sign in with Google',
                  style: GoogleFonts.lato(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
