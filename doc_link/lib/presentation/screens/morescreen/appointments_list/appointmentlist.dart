import 'package:doc_link/const/const.dart';
import 'package:doc_link/widgets/custom_appbar_widgets.dart';
import 'package:flutter/material.dart';

class AppointmentListPage extends StatelessWidget {
  const AppointmentListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Appointment List Page'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight15,
          Text(
            'Upcoming',
            style: kTextStyleLargeBlack,
          ),
          kHeight15,
          Container(
            height: 120,
            width: double.infinity,
            color: const Color.fromARGB(255, 161, 184, 162),
          )
        ],
      ),
    );
  }
}
