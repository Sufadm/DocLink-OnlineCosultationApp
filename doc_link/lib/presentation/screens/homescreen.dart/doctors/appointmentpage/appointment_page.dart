import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doc_link/model/doctor_profile_model.dart';
import 'package:doc_link/services/firestore_service.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/widgets/elevated_button_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../../model/add_details_model.dart';

class AppointmantPage extends StatelessWidget {
  final remarksController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ProfileModel profile;
  AppointmantPage({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeight10,
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                      foregroundColor: const Color.fromARGB(255, 98, 78, 20),
                      radius: 70,
                    ),
                  ),
                  kHeight10,
                  Center(
                    child: Text(
                      profile.name,
                      style: kTextStyleMediumBlack,
                    ),
                  ),
                  kHeight10,
                  Center(
                    child: Text(
                      profile.place,
                      style: kTextStyleMediumBlack,
                    ),
                  ),
                  kHeight10,
                  Center(
                    child: Text(
                      profile.gender,
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
                  StreamBuilder<List<AddDetailModel>>(
                    stream: FirestoreService().getAllDetailsDoctors(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<AddDetailModel> details = snapshot.data!;
                        final selectedDoctorId = profile
                            .uid; // Assuming profile.uid represents the selected doctor's ID

                        // Filter the list to get the details of the selected doctor
                        final selectedDoctorDetails = details
                            .where((detail) => detail.uid == selectedDoctorId);

                        if (selectedDoctorDetails.isNotEmpty) {
                          final AddDetailModel detail =
                              selectedDoctorDetails.first;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                detail.time,
                                style: kTextStyleMedium,
                              ),
                              Text(
                                detail.place,
                                style: kTextStyleMediumBlack,
                              ),
                              Text(
                                'Fee : ${detail.fee}',
                                style: kTextStyleMedium,
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox
                              .shrink(); // Render an empty container if no details found for the selected doctor
                        }
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const SizedBox
                            .shrink(); // Render an empty container while waiting for data
                      }
                    },
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
                  ElevatedButtons(text: 'Next', onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      ),
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
}
