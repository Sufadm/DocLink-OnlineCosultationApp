import 'package:doc_link/model/profile_model.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/viewallpages/categerie_list_doctors/categorie_list_doctors.dart';
import 'package:doc_link/services/firestore_service.dart';
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
      //?all categeries here------------------
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<List<ProfileModel>>(
            stream: FirestoreService().getDoctorsProfilesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<ProfileModel> doctors = snapshot.data!;
                  Set<String> uniqueCategories = <String>{};

                  //?collect unique categories-----------

                  for (var doctor in doctors) {
                    uniqueCategories.add(doctor.category);
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: uniqueCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      String category = uniqueCategories.elementAt(index);
                      List<ProfileModel> doctorsInCtegorie = doctors
                          .where((doctor) => doctor.category == category)
                          .toList();
                      return ViewAllCategorieWidget(
                        ontap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategorieListDoctors(
                            doctors: doctorsInCtegorie,
                          );
                        })),
                        categoriename: category,
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  const Text('Error');
                }
              }
              return Container();
            },
          )),
    );
  }
}
