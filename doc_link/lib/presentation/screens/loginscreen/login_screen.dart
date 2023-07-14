import 'package:doc_link/services/otp_auth.dart';
import 'package:doc_link/presentation/screens/bottomnav/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../services/googlesignin_service.dart';
import '../../../provider/loginpage_prov.dart';
import '../../../shared/const/const.dart';
import '../../../core/elevated_button_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return AuthenticationProvider();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
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
                    //?phone number form---------
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
                    Consumer<AuthenticationProvider>(
                      builder: (context, value, child) {
                        return value.loading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButtons(
                                text: 'Send OTP',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    value.loading = true;
                                    // Validation successful, proceed with sending OTP
                                    AuthenticationService.sendPhoneNumber(
                                        phoneController.text, context);
                                  }
                                },
                              );
                      },
                    ),

                    kHeight25,
                    Center(
                      child: Text(
                        'OR',
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    //?SIGN IN BUTTON---------
                    const SizedBox(
                      height: 27,
                    ),

                    Center(
                      child: SizedBox(
                        height: 47,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 234, 234, 234))),
                            onPressed: () async {
                              final userCredential = await signInWithGoogle();
                              if (userCredential != null) {
                                //? User signed in successfully
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const BottomNav();
                                }));
                              } else {}
                            },
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/800px-Google_2015_logo.svg.png',
                              height: 35,
                              fit: BoxFit.cover,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
