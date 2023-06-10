import 'package:doc_link/presentation/screens/morescreen/appointments_list/widget/notificationlist_container.dart';
import 'package:doc_link/widgets/custom_appbar_widgets.dart';
import 'package:flutter/material.dart';

class AppointmentListPage extends StatelessWidget {
  const AppointmentListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Appointment List Page'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: 4,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 15),
          itemBuilder: (BuildContext context, int index) {
            //?appointmentListWidget----------------------
            return const NotificationListDetailsWidget();
          },
        ),
      ),
    );
  }
}
