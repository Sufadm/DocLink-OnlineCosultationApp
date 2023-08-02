import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../appointment_page.dart';

class TimeSlotWidget extends StatefulWidget {
  const TimeSlotWidget({
    Key? key,
    required this.timeSlots,
    required this.onSlotSelected,
    required this.selectedTime,
    required this.doctorId,
  }) : super(key: key);

  final List<TimeOfDay> timeSlots;
  final Function(TimeOfDay) onSlotSelected;
  final TimeOfDay? selectedTime;
  final String doctorId;
  @override
  _TimeSlotWidgetState createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  Set<TimeOfDay> bookedSlots = {}; // Add a set to store the booked time slots

  TimeOfDay? selectedTime;
  List<DocumentSnapshot> bookedSlotsData = []; // Store the booked slots data

  @override
  void initState() {
    super.initState();
    fetchBookedSlots(); // Fetch the booked slots data from Firebase
  }

  Future<void> fetchBookedSlots() async {
    final appointmentDate = AppointmentDateProvider().getDate();
    final formattedDate = DateFormat('MMMM d').format(appointmentDate!);
    final querySnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where('doctorId', isEqualTo: widget.doctorId)
        .where('appointmentDate', isEqualTo: formattedDate)
        .get();
    setState(() {
      bookedSlotsData = querySnapshot.docs;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1.9,
        crossAxisCount: 4,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.timeSlots.length,
      itemBuilder: (context, index) {
        final time = widget.timeSlots[index];
        final formattedTime = time.format(context);
        final isSelected = time == selectedTime;
        final isBooked =
            bookedSlots.contains(time); // Check if the time slot is booked

        //? Check availability using the get method
        final isAvailable = !bookedSlotsData.any((doc) {
          final bookedTime = doc.get('appointmentTime');
          return bookedTime == formattedTime;
        });

        return GestureDetector(
          onTap: () async {
            if (!isAvailable) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Slot Unavailable',
                      style: GoogleFonts.lato(),
                    ),
                    content: Text(
                      'The selected time slot is already booked!.',
                      style: GoogleFonts.outfit(),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'OK',
                          style: GoogleFonts.lato(
                              color: kBlackColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              );
              return;
            }

            setState(() {
              selectedTime = isSelected ? null : time;
            });
            widget.onSlotSelected(time);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.grey : Colors.black,
                width: 1.0,
              ),
              color: isBooked
                  ? Colors.grey.shade300
                  : (isSelected
                      ? Colors.grey
                      : (isAvailable
                          ? Colors.white
                          : const Color.fromARGB(136, 133, 133, 133))),
            ),
            height: 20,
            width: 147,
            child: Center(
              child: Text(
                formattedTime,
                style: TextStyle(
                  color: isSelected || isBooked || !isAvailable
                      ? Colors.white
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
