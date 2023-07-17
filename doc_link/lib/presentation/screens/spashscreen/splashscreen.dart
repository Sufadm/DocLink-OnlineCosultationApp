import 'package:doc_link/shared/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../bottomnav/bottomnav.dart';
import '../loginscreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    navigateToHomescreen();
    super.initState();
  }

//?Navigating Function
  navigateToHomescreen() async {
    await Future.delayed(const Duration(seconds: 4));

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const BottomNav();
        }),
      );
    } else {
      //ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlueButtonsColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                'https://lottie.host/c8907b14-46b6-47cb-ae28-0a0cffe7f667/tx1lBXPodj.json',
                height: 400,
                width: 400),
            kHeight25,
            kHeight5,
            Container(
              margin: const EdgeInsets.only(right: 50),
              child: Text(
                'DocLink',
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: kWhiteColor,
                    fontSize: 35),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
            )
          ],
        ),
      ),
    );
  }
}
