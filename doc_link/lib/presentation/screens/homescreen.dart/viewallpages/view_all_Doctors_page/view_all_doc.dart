import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/doctors_details.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/viewallpages/view_all_Doctors_page/widgets/doctors_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/custom_appbar_widgets.dart';

class ViewAllDoctorsPage extends StatelessWidget {
  const ViewAllDoctorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: 'All Doctors',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            kHeight15,
            SearchBar(
              hintText: 'Search doctor',
              leading: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Icon(Icons.search)),
            ),
            //?all doctors list here-----
            kHeight15,
            DoctorsListWidget(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const DoctorsDetails();
              })),
              doctorname: 'Doctor name 1',
            ),
            kHeight10,
            const DoctorsListWidget(
              doctorname: 'Doctor name 2',
            ),
            kHeight10,
            const DoctorsListWidget(
              doctorname: 'Doctor name 3',
            ),
            kHeight10,
            const DoctorsListWidget(
              doctorname: 'Doctor name 4',
            ),
            kHeight10,
            const DoctorsListWidget(
              doctorname: 'Doctor name 5',
            ),
          ],
        ),
      ),
    );
  }
}
