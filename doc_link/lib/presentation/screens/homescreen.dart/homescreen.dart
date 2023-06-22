import 'package:carousel_slider/carousel_slider.dart';
import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/viewallpages/view_all_Doctors_page/view_all_doc.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/viewallpages/viewall_categories_page/view_all_catgires.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/widgets/carousal_widget.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/widgets/categories_widget.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/widgets/doctors_list_widget.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final documents = snapshot.data!.docs;
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) {
            //final doctor = documents[index];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        'Hello Sufad M',
                        style: kTextStyleLarge,
                      ),
                    ),
                    kHeight20,
                    SearchBar(
                      hintText: 'Search a doctor',
                      leading: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Icon(Icons.search)),
                    ),
                    kHeight15,
                    //?Carousal Slider Widget Static
                    CarouselSlider(
                      items: const [
                        CarousalWidget(
                          networkimage:
                              'https://www.healthworkscollective.com/wp-content/uploads/2021/02/Medical-Consultation.jpg',
                        ),
                        CarousalWidget(
                            networkimage:
                                'https://www.eatthis.com/wp-content/uploads/sites/4/2022/04/talk-to-doctor-e1650409953356.jpg?quality=82&strip=1'),
                        CarousalWidget(
                            networkimage:
                                'https://naturatermospa.com/wp-content/uploads/2019/10/image-11.png')
                      ],
                      options: CarouselOptions(
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          animateToClosest: true),
                    ),
                    kHeight10,
                    //?Title Widget-----------------------------------------
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
                            7,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 7.0),
                              child: CategoriesWidget(
                                  categories: 'categories ${index + 1}'),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //?Title Widget-------------
                    TitleWidget(
                      titleName: 'All Doctors',
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewAllDoctorsPage(),
                          )),
                    ),
                    kHeight15,
                    //?Doctors Widget---
                    const DoctorsWidget(
                      networkImage:
                          'https://res.cloudinary.com/ekincare/image/upload/v1583490813/gfznfh2yzbm6hruqjftx.jpg',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
