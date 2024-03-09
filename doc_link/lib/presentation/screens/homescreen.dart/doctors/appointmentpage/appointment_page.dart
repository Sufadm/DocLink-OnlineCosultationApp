import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doc_link/model/doctor_profile_model.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/appointmentpage/success_screen.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/appointmentpage/widgets/timeslot_widget.dart';
import 'package:doc_link/provider/loginpage_prov.dart';
import 'package:doc_link/services/firestore_service.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/core/elevated_button_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../../model/add_details_model.dart';
import '../../../../../services/notification_service.dart';
import '../../../../../shared/api_key.dart';
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
  Set<TimeOfDay> bookedSlots = {}; // Initialize an empty set
  TimeOfDay? selectedTime; // Add the selectedTime variable
  bool isTimeSlotSelected = false;

  final CollectionReference paymentsCollection =
      FirebaseFirestore.instance.collection('appointments');

  Razorpay? _razorpay;

  final globalKey = GlobalKey();

  final remarksController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
//?Razor pay payment-----------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePayamentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void handleSlotSelection(TimeOfDay selectedTime) {
    setState(() {
      if (bookedSlots.contains(selectedTime)) {
        bookedSlots.remove(selectedTime);
        this.selectedTime = null;
        isTimeSlotSelected = false;
      } else {
        bookedSlots.add(selectedTime);
        this.selectedTime = selectedTime;
        isTimeSlotSelected = true;
      }
    });
  }

  void makePayment(String fee) async {
    final numericFee =
        int.parse(RegExp(r'\d+').firstMatch(fee)?.group(0) ?? '0');
    final multipliedFee = numericFee * 100;
    var options = {
      'key': razorpaykey,
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

  @override
  void dispose() {
    _razorpay?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return AuthenticationProvider();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: StreamBuilder<List<AddDetailModel>>(
                  stream: FirestoreService().getAllDetailsDoctors(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<AddDetailModel> details = snapshot.data!;
                      final selectedDoctorId = widget.profile.uid;

                      final selectedDoctorDetails = details
                          .where((detail) => detail.uid == selectedDoctorId)
                          .toList();

                      if (selectedDoctorDetails.isNotEmpty) {
                        final detail = selectedDoctorDetails.first;
                        final startTime =
                            DateFormat('hh:mm a').parse(detail.startTime);
                        final endTime =
                            DateFormat('hh:mm a').parse(detail.endTime);
                        final timePerPerson = int.parse(detail.timePerPerson);

                        final fee = int.parse(detail.fee);
                        final List<TimeOfDay> timeSlots = [];
                        var currentTime = startTime;

                        while (currentTime.isBefore(endTime)) {
                          timeSlots.add(TimeOfDay.fromDateTime(currentTime));
                          currentTime =
                              currentTime.add(Duration(minutes: timePerPerson));
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              // controller: _datePickerController,
                              activeDates: [
                                DateTime.now(),
                              ],
                              daysCount: 10,
                              initialSelectedDate: DateTime.now(),
                              selectionColor: Colors.black,
                              selectedTextColor: Colors.white,
                              onDateChange: (date) {
                                AppointmentDateProvider().setDate(date);
                              },
                            ),
                            kHeight10,
                            kHeight20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Available',
                                  style: kTextStyleLargeBlack,
                                ),
                                Text(
                                  'Fee: $fee/-',
                                  style: GoogleFonts.outfit(),
                                )
                              ],
                            ),
                            kHeight15,
                            //?TimeSlotWidget-----------------------------------
                            Column(
                              children: [
                                SingleChildScrollView(
                                  child: TimeSlotWidget(
                                    doctorId: widget.profile.uid!,
                                    // bookedSlots: bookedSlots,
                                    onSlotSelected: handleSlotSelection,
                                    timeSlots: timeSlots,
                                    selectedTime: selectedTime,
                                  ),
                                ),
                                kHeight25,

                                //?PAY Button-----------------------------------
                                Consumer<AuthenticationProvider>(
                                  builder: (context, value, child) {
                                    return value.loading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : ElevatedButtons(
                                            text: 'Pay',
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (isTimeSlotSelected) {
                                                  value.loading = true;
                                                  final userUid = FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid;
                                                  final documentSnapshot =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'userprofile')
                                                          .doc(userUid)
                                                          .get();

                                                  final querySnapshot =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('doctors')
                                                          .where(
                                                              'doctorId',
                                                              isEqualTo: widget
                                                                  .profile.uid)
                                                          .where(
                                                              'appointmentTime',
                                                              isEqualTo:
                                                                  // ignore: use_build_context_synchronously
                                                                  selectedTime
                                                                      ?.format(
                                                                          context))
                                                          .get();
                                                  if (querySnapshot
                                                      .docs.isNotEmpty) {
                                                    //?Already Booked Logic-----
                                                    // ignore: use_build_context_synchronously
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            'Time Slot Already Booked',
                                                            style: GoogleFonts
                                                                .outfit(),
                                                          ),
                                                          content: Text(
                                                            'The selected time slot is already booked. Please choose a different time slot.',
                                                            style: GoogleFonts
                                                                .outfit(),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'OK'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    value.loading = false;
                                                    return;
                                                  }

                                                  if (isTimeSlotSelected) {
                                                    if (documentSnapshot
                                                        .exists) {
                                                      for (final detail
                                                          in selectedDoctorDetails) {
                                                        makePayment(detail.fee);
                                                        value.loading = false;
                                                      }
                                                    } else {
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return ProfileScreen(
                                                          message:
                                                              'Please create a profile',
                                                        );
                                                      }));
                                                    }
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        'Please select a time slot.',
                                                    timeInSecForIosWeb: 4,
                                                  );
                                                  // ignore: use_build_context_synchronously
                                                }
                                              }
                                            },
                                          );
                                  },
                                )
                              ],
                            ),
                          ],
                        );
                      } else {
                        return elsemethod(context);
                      }
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//?---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //?if SNAPSHOT has No data----------------------------------------------------

  Column elsemethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.profile.imageUrl),
            foregroundColor: const Color.fromARGB(255, 98, 78, 20),
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
        Text(
          'Doctor not Availbale Now',
          style: GoogleFonts.outfit(color: Colors.red),
        ),
        const SizedBox(
          height: 280,
        ),
        ElevatedButtons(
          onPressed: () {},
          text: 'Pay',
        )
      ],
    );
  }

  //?PAYMENT METHOD SUCCESS METHOD----------------------------------------------
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('userprofile')
        .doc(userUid)
        .get();
    final appointmentDate = AppointmentDateProvider().getDate();
    final formattedDate = DateFormat('MMMM d').format(appointmentDate!);

    final appointmentData = {
      'fcmToken': documentSnapshot['fcmToken'],
      'paymentid': response.paymentId,
      'gender': documentSnapshot['gender'],
      'age': documentSnapshot['age'],
      'image': documentSnapshot['imageUrl'],
      'userName': documentSnapshot['name'],
      'userId': userUid,
      'doctorImage': widget.profile.imageUrl,
      'doctorId': widget.profile.uid,
      'doctorName': widget.profile.name,
      'doctorCategory': widget.profile.category,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'appointmentDate': formattedDate,
      'appointmentTime': selectedTime?.format(context),
    };
//?All values are adding to firestore Collections-------------------------------
    final doctorAppointmentsCollection =
        FirebaseFirestore.instance.collection('doctors');

    await doctorAppointmentsCollection.add(appointmentData);

    await Future.delayed(const Duration(seconds: 2));
    await NotificationService().sendNotificationToDoctor(
      widget.profile.uid!,
      userUid,
      documentSnapshot['fcmToken'],
      documentSnapshot['name'],
      selectedTime?.format(context) ?? '',
    );

    // ignore: use_build_context_synchronously
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return SuccessScreen(
          paymentId: response.paymentId!,
          date: formattedDate,
          time: selectedTime?.format(context) ?? '',
          categorie: widget.profile.category,
          image: widget.profile.imageUrl,
          name: widget.profile.name,
        );
      }),
    );
  }

  void _handlePayamentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: 'ERROR: ${response.code}-${response.message}',
      timeInSecForIosWeb: 4,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: 'EXTERNAL WALLET: ${response.walletName}',
      timeInSecForIosWeb: 4,
    );
  }
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
