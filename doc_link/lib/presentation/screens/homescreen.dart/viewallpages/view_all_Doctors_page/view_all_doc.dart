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
    )
        //body: ,
        );
  }
}
