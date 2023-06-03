import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/homescreen.dart/doctors/doctors_details.dart';
import 'package:flutter/material.dart';

class DoctorsWidget extends StatelessWidget {
  final String networkImage;
  const DoctorsWidget({
    super.key,
    required this.networkImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(255, 226, 226, 226)),
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
                      'Doctor Name',
                      style: kTextStyleLargeBlack,
                    ),
                    kHeight10,
                    Text(
                      'QUALIFICATION',
                      style: kTextStyleMediumBlack,
                    ),
                    kHeight10,
                    Text(
                      'CATEGORIE',
                      style: kTextStyleMediumBlack,
                    ),
                    kHeight10,
                    SizedBox(
                        width: 90,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kLightBlueColor)),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const DoctorsDetails();
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
