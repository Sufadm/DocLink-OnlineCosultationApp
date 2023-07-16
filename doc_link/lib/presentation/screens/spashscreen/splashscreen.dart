import 'package:doc_link/presentation/screens/loginscreen/login_screen.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bottomnav/bottomnav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.repeat(reverse: false);
    navigateToHomescreen();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

//?Navigating Function
  navigateToHomescreen() async {
    // await Future.delayed(const Duration(seconds: 3));
    await Future.delayed(const Duration(milliseconds: 2600));

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      //  ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const BottomNav();
        }),
      );
    } else {
      // ignore: use_build_context_synchronously
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
      backgroundColor: const Color.fromARGB(255, 0, 26, 120),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Image.asset(
                "asset_images/online-doctor-consultation-flat-design-logo-aplication-doctor-cartoon-for-mobile-app-free-vector-removebg-preview.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'DocLink',
              style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                  fontSize: 35),
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
