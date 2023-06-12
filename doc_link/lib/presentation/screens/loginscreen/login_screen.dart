import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/loginscreen/otpscreen.dart';
import 'package:doc_link/presentation/screens/loginscreen/widgets/google_signin_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/elevated_button_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SafeArea(
            child: Form(
              key: _formKey,
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
                  //?Image section-
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
                  //?phone number form-
                  TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number.';
                      }
                      if (value.length != 10) {
                        return 'Phone number must be 10 digits.';
                      }
                      // You can add additional validation logic here if needed
                      return null; // Return null if the input is valid
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: '+91 ',
                      prefixStyle: GoogleFonts.lato(fontSize: 16),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  kHeight15,
                  Text(
                    '  We will send you a one time password to this mobile number',
                    style: GoogleFonts.lato(),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  //? OTP Button widget-
                  ElevatedButtons(
                    text: 'Send OTP',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Validation successful, proceed with sending OTP
                        sendPhoneNumber();
                      }
                    },
                  ),
                  kHeight25,
                  Center(
                    child: Text(
                      'OR',
                      style: kTextStyleLargeBlack,
                    ),
                  ),
                  //?SIGN IN BUTTON--------
                  const SizedBox(
                    height: 27,
                  ),
                  const GoogleSignInButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      auth.verifyPhoneNumber(
          phoneNumber: '+91${phoneController.text}',
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OtpScreen(
                verificationId: verificationId,
              );
            }));
          },
          codeAutoRetrievalTimeout: (verificationId) {},
          timeout: const Duration(seconds: 60));
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // void checkUserLoggedIn() {
  //   if (_auth.currentUser != null) {
  //     // User is already signed in, navigate to the home screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const BottomNav()),
  //     );
  //   }
  // }
}
