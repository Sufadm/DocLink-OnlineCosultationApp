import 'package:doc_link/presentation/screens/homescreen.dart/doctors/doctors_details.dart';
import 'package:flutter/material.dart';

import '../widgets/box_widget.dart';

class ViewAllCategoriesPage extends StatelessWidget {
  const ViewAllCategoriesPage({Key? key}) : super(key: key);

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
          'All Categories',
          style: TextStyle(
            color: Colors.black, // Change the text color here
            fontSize: 20, // Adjust the font size if needed
            fontWeight: FontWeight.bold, // Adjust the font weight if needed
          ),
        ),
      ),
      //?all categeries here----------------
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const DoctorsDetails();
            })),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return ViewAllCategorieWidget(
                  categoriename: 'Categorie ${index + 1}',
                );
              },
            ),
          )),
    );
  }
}
