import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimeSlotWidget extends StatefulWidget {
  const TimeSlotWidget({
    Key? key,
    required this.timeSlots,
    required this.onSlotSelected,
    required this.selectedTime,
  }) : super(key: key);

  final List<TimeOfDay> timeSlots;
  final Function(TimeOfDay) onSlotSelected;
  final TimeOfDay? selectedTime;

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
    final querySnapshot =
        await FirebaseFirestore.instance.collection('doctors').get();
    setState(() {
      bookedSlotsData = querySnapshot.docs;
    });
  }

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

        return GestureDetector(
          onTap: () {
            if (isSelected) {
              setState(() {
                selectedTime = null;
              });
            } else {
              setState(() {
                selectedTime = time;
              });
              widget.onSlotSelected(time);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.grey : Colors.black,
                width: 1.0,
              ),
              color: isSelected ? Colors.grey : Colors.white,
            ),
            height: 20,
            width: 147,
            child: Center(
              child: Text(
                formattedTime,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.green,
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
