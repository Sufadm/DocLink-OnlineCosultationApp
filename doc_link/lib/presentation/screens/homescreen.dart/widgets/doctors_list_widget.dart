import 'package:doc_link/model/doctor_profile_model.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/doctors_details.dart';
import 'package:doc_link/services/firestore_service.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:flutter/material.dart';

class DoctorsWidget extends StatelessWidget {
  final String networkImage;
  const DoctorsWidget({
    super.key,
    required this.networkImage,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProfileModel>>(
      stream: FirestoreService().getDoctorsProfilesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<ProfileModel> doctors = snapshot.data!;
            String name = doctors[1].name;
            String qualification = doctors[1].qualification;
            String category = doctors[1].category;

            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(253, 218, 223, 252),
              ),
              height: 260,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 260,
                    width: 170,
                    child: Image.network(
                      networkImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: Column(
                          children: [
                            Text(
                              name,
                              style: kTextStyleLargeBlack,
                            ),
                            kHeight10,
                            Text(
                              qualification,
                              style: kTextStyleMediumBlack,
                            ),
                            kHeight10,
                            Text(
                              category,
                              style: kTextStyleMediumBlack,
                            ),
                            kHeight10,
                            SizedBox(
                                width: 90,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kLightBlueColor)),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DoctorsDetails(
                                          profile: doctors[1],
                                        );
                                      }));
                                    },
                                    child: const Text('Book')))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
