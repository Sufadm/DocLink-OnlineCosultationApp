import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doc_link/model/doctor_profile_model.dart';
import 'package:doc_link/services/firestore_service.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/widgets/elevated_button_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../../model/add_details_model.dart';
import '../../../profilescreen/profilescreen.dart';

class AppointmantPage extends StatefulWidget {
  final ProfileModel profile;

  const AppointmantPage({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<AppointmantPage> createState() => _AppointmantPageState();
}

class _AppointmantPageState extends State<AppointmantPage> {
  Razorpay? _razorpay;

  final globalKey = GlobalKey();

  final remarksController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePayamentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment(String fee) async {
    // Extract numeric part from fee using regular expression
    final numericFee =
        int.parse(RegExp(r'\d+').firstMatch(fee)?.group(0) ?? '0');
    final multipliedFee = numericFee * 100;
    var options = {
      //'key': razorpaykey,
      'amount': multipliedFee,
      'name': widget.profile.name,
      "description": 'Doctor Appointment',
      'prefill': {
        'contact': widget.profile.phone,
        'email': widget.profile.email
      },
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: 'Error occurred during payment.',
        timeInSecForIosWeb: 4,
      );
    }
  }

  // @override
  // void dispose() {
  //   _razorpay?.clear(); // Clear the Razorpay instance
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: StreamBuilder<List<AddDetailModel>>(
                stream: FirestoreService().getAllDetailsDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<AddDetailModel> details = snapshot.data!;
                    final selectedDoctorId = widget.profile
                        .uid; // Assuming profile.uid represents the selected doctor's ID

                    final selectedDoctorDetails = details
                        .where((detail) => detail.uid == selectedDoctorId);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kHeight10,
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.profile.imageUrl),
                            foregroundColor:
                                const Color.fromARGB(255, 98, 78, 20),
                            radius: 70,
                          ),
                        ),
                        kHeight10,
                        Center(
                          child: Text(
                            widget.profile.name,
                            style: kTextStyleMediumBlack,
                          ),
                        ),
                        kHeight10,
                        Center(
                          child: Text(
                            widget.profile.place,
                            style: kTextStyleMediumBlack,
                          ),
                        ),
                        kHeight10,
                        Center(
                          child: Text(
                            widget.profile.gender,
                            style: kTextStyleMediumBlack,
                          ),
                        ),
                        kHeight10,
                        const Divider(
                          thickness: 1,
                        ),
                        kHeight10,
                        Text(
                          'Select Date',
                          style: kTextStyleLargeBlack,
                        ),
                        kHeight25,
                        DatePicker(
                          DateTime.now(),
                          daysCount: 10,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Colors.black,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            // New date selected
                            AppointmentDateProvider().setDate(date);
                          },
                        ),
                        kHeight10,
                        kHeight20,
                        Text(
                          'Available',
                          style: kTextStyleLargeBlack,
                        ),
                        kHeight15,
                        if (selectedDoctorDetails.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDoctorDetails.first.time,
                                style: kTextStyleMedium,
                              ),
                              Text(
                                selectedDoctorDetails.first.place,
                                style: kTextStyleMediumBlack,
                              ),
                              Text(
                                'Fee : ${selectedDoctorDetails.first.fee}',
                                style: kTextStyleMedium,
                              ),
                            ],
                          ),
                        if (selectedDoctorDetails.isEmpty)
                          Text(
                            'Doctor Not Availbale Now !',
                            style: GoogleFonts.lato(color: Colors.red),
                          ),
                        kHeight15,
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Remarks';
                            }
                            return null;
                          },
                          controller: remarksController,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Remarks',
                          ),
                        ),
                        kHeight15,
                        ElevatedButtons(
                          text: 'Pay',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final userUid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              final documentSnapshot = await FirebaseFirestore
                                  .instance
                                  .collection('userprofile')
                                  .doc(userUid)
                                  .get();
                              if (documentSnapshot.exists) {
                                makePayment(selectedDoctorDetails.first.fee);
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProfileScreen(
                                    message: 'Please create a profile',
                                  );
                                }));
                              }
                            }
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const SizedBox
                        .shrink(); // Render an empty container while waiting for data
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void storeDataToFirestore() {
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    // Create a new document with a unique ID in the Firestore collection
    final appointmentData = {
      'userUid': userUid,
      'profile': {
        'name': widget.profile.name,
        'imageUrl': widget.profile.imageUrl,
        'place': widget.profile.place,
        'gender': widget.profile.gender,
        'phone': widget.profile.phone,
        'email': widget.profile.email,
      },
      'date': AppointmentDateProvider().getDate().toString(),
      // Include any other relevant fields you want to store
    };

    FirebaseFirestore.instance
        .collection('appointments')
        .add(appointmentData)
        .then((value) {
      // Document was successfully added
      final appointmentId = value.id;
      Fluttertoast.showToast(
        msg: 'Appointment stored in Firestore with ID: $appointmentId',
        timeInSecForIosWeb: 4,
      );
    }).catchError((error) {
      // Error occurred while adding document
      debugPrint(error.toString());
      Fluttertoast.showToast(
        msg: 'Error occurred while storing appointment.',
        timeInSecForIosWeb: 4,
      );
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
      msg: 'SUCCESS PAYMENT: ${response.paymentId}',
      timeInSecForIosWeb: 4,
    );
  }
}

void _handlePayamentError(PaymentFailureResponse response) {
  Fluttertoast.showToast(
    msg: 'ERROR HERE: ${response.code}-${response.message}',
    timeInSecForIosWeb: 4,
  );
}

void _handleExternalWallet(ExternalWalletResponse response) {
  Fluttertoast.showToast(
    msg: 'EXTERNAL WALLET: ${response.walletName}',
    timeInSecForIosWeb: 4,
  );
}

class AppointmentDateProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  DateTime? getDate() {
    return selectedDate;
  }
}
