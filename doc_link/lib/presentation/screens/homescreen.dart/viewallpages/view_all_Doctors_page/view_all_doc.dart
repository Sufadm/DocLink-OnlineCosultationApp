import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/viewallpages/view_all_Doctors_page/widgets/doctors_list_widget.dart';
import 'package:flutter/material.dart';

class ViewAllDoctorsPage extends StatelessWidget {
  const ViewAllDoctorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'All Doctors',
          style: TextStyle(
            color: Colors.black, // Change the text color here
            fontSize: 20, // Adjust the font size if needed
            fontWeight: FontWeight.bold, // Adjust the font weight if needed
          ),
        ),
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
            kHeight15,
            const DoctorsListWidget(
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
