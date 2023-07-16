import 'package:doc_link/model/doctor_profile_model.dart';
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
        iconTheme: const IconThemeData(
          color: Colors.black, // Change your color here
        ),
        title: const Text(
          'All Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //?all categeries here------------------------------------
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<List<ProfileModel>>(
            stream: FirestoreService().getDoctorsProfilesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<ProfileModel> doctors = snapshot.data!;
                  Set<String> uniqueCategories = <String>{};

                  //?collect unique categories------------------

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
                      List<ProfileModel> doctorsInCategorie = doctors
                          .where((doctor) => doctor.category == category)
                          .toList();
                      return ViewAllCategorieWidget(
                        ontap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategorieListDoctors(
                            doctors: doctorsInCategorie,
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
