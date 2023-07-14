import 'package:doc_link/presentation/screens/morescreen/appointments_list/widget/notificationlist_container.dart';
import 'package:doc_link/core/custom_appbar_widgets.dart';
import 'package:flutter/material.dart';

class AppointmentListPage extends StatelessWidget {
  const AppointmentListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(text: 'Appointment List Page'),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: NotificationListDetailsWidget(),
      ),
    );
  }
}
