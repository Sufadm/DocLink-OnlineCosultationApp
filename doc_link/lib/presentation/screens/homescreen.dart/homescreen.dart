import 'package:carousel_slider/carousel_slider.dart';
import 'package:doc_link/model/doctor_profile_model.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/viewallpages/categerie_list_doctors/categorie_list_doctors.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/widgets/categories_widget.dart';
import 'package:doc_link/services/firestore_service.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/viewallpages/view_all_Doctors_page/view_all_doc.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/viewallpages/viewall_categories_page/view_all_catgories.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/widgets/carousal_widget.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/widgets/doctors_list_widget.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/widgets/title_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/search_form.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProfileModel>>(
      stream: FirestoreService().getDoctorsProfilesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<ProfileModel> doctors = snapshot.data!;
            String imageUrl = doctors[1].imageUrl;

            return SafeArea(
              child: Scaffold(
                  body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          greeting(),
                          style: kTextStyleLarge,
                        ),
                      ),
                      kHeight20,
                      //?Search Button------------------------------------------
                      const SearchForm(),
                      kHeight15,
                      //?Carousal Slider Widget Static
                      CarouselSlider(
                        items: const [
                          CarousalWidget(
                            assetimage: 'asset_images/Medical-Consultation.jpg',
                          ),
                          CarousalWidget(
                              assetimage: 'asset_images/image-11.png'),
                          CarousalWidget(
                              assetimage:
                                  'asset_images/gfznfh2yzbm6hruqjftx.jpg'),
                          CarousalWidget(assetimage: 'asset_images/1.jpg')
                        ],
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            animateToClosest: true),
                      ),
                      kHeight10,
                      //?Title Widget-------------------------------------------
                      TitleWidget(
                          titleName: 'Categories',
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ViewAllCategoriesPage(),
                              ))),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: List.generate(
                              2,
                              (index) {
                                final category = doctors[index].category;
                                final isFirstOccurrence = doctors.indexWhere(
                                        (doc) => doc.category == category) ==
                                    index;
                                if (isFirstOccurrence) {
                                  final doctorsInCategory = doctors
                                      .where((doc) => doc.category == category)
                                      .toList();

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 7.0),
                                    child: CategoriesWidget(
                                      ontap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategorieListDoctors(
                                                      doctors:
                                                          doctorsInCategory))),
                                      categories: category,
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ),
                      ),

                      //?Title Widget-------------------------------------------
                      TitleWidget(
                        titleName: 'All Doctors',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewAllDoctorsPage(),
                            )),
                      ),
                      kHeight15,
                      //?Doctors Widget-----------------------------------------

                      DoctorsWidget(networkImage: imageUrl),
                    ],
                  ),
                ),
              )),
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
}
