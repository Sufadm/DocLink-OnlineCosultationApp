import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/widgets/elevated_button_widgets.dart';
import 'package:flutter/material.dart';

class AppointmantPage extends StatefulWidget {
  const AppointmantPage({Key? key}) : super(key: key);

  @override
  State<AppointmantPage> createState() => _AppointmantPageState();
}

class _AppointmantPageState extends State<AppointmantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight10,
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Center(
                  child: CircleAvatar(
                    radius: 70,
                  ),
                ),
                kHeight10,
                Center(
                  child: Text(
                    'DoctorName',
                    style: kTextStyleMediumBlack,
                  ),
                ),
                kHeight10,
                Center(
                  child: Text(
                    'Place',
                    style: kTextStyleMediumBlack,
                  ),
                ),
                kHeight10,
                Center(
                  child: Text(
                    'Gender',
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
                    setState(() {});
                  },
                ),
                kHeight20,
                Text(
                  'Available',
                  style: kTextStyleLargeBlack,
                ),
                kHeight15,
                Text(
                  'Time 7.00 AM',
                  style: kTextStyleMediumBlack,
                ),
                kHeight15,
                TextFormField(
                  maxLines: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Remarks',
                  ),
                ),
                kHeight15,
                ElevatedButtons(text: 'Next', onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
