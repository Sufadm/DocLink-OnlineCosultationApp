import 'dart:async';
import 'package:doc_link/presentation/screens/bottomnav/bottomnav.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:provider/provider.dart';
import '../../../provider/otp_screen_provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? _timer;
  final int _timerDuration = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final provider = Provider.of<OtpScreenProvider>(context, listen: false);
      if (provider.currentSeconds < _timerDuration) {
        provider.incrementSeconds();
      } else {
        _timer?.cancel();
        provider.setTimerFinished();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OtpScreenProvider>(
      create: (_) => OtpScreenProvider(widget.verificationId),
      child: Scaffold(
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
                        color: const Color.fromARGB(255, 1, 43, 114),
                      ),
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
                    child: Consumer<OtpScreenProvider>(
                      builder: (context, provider, _) {
                        return OtpPinField(
                          onSubmit: (String text) async {
                            bool verificationSuccess =
                                await provider.verifyOtp(context, text);
                            if (verificationSuccess) {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const BottomNav();
                                }),
                              );
                            }
                          },
                          onChange: (String text) {
                            provider.clearErrorMessage();
                          },
                          textInputAction: TextInputAction.done,
                          otpPinFieldStyle: const OtpPinFieldStyle(
                            defaultFieldBorderColor:
                                Color.fromARGB(255, 0, 27, 177),
                          ),
                          maxLength: 6,
                          otpPinFieldDecoration:
                              OtpPinFieldDecoration.defaultPinBoxDecoration,
                        );
                      },
                    ),
                  ),
                  kHeight20,
                  Center(
                    child: Text(
                      'We have sent you a one-time password',
                      style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 124, 121, 121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'to your Number',
                      style: GoogleFonts.lato(
                        color: const Color.fromARGB(255, 124, 121, 121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  kHeight25,
                  Consumer<OtpScreenProvider>(
                    builder: (context, provider, _) {
                      if (provider.errorMessage != null) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 19),
                          child: Text(
                            provider.errorMessage!,
                            style: GoogleFonts.lato(color: Colors.red),
                          ),
                        );
                      } else if (provider.currentSeconds > 0) {
                        final remainingSeconds =
                            _timerDuration - provider.currentSeconds;
                        return Text(
                          'Please Enter OTP $remainingSeconds before Timeout',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  kHeight10,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
