import 'package:doc_link/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentDetails extends StatelessWidget {
  final List<String> names;
  final List<String> images;
  final List<String> times;
  const AppointmentDetails({
    Key? key,
    required this.names,
    required this.times,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlueButtonsColor,
        title: const Text('AppointmentDetails'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: ListView.separated(
                  separatorBuilder: (context, index) => kHeight10,
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    final name = names[index];
                    final time = times[index];
                    final image = images[index];

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kWhiteColor,
                      ),
                      child: Column(
                        children: [
                          kHeight15,
                          CircleAvatar(
                            backgroundImage: NetworkImage(image),
                            radius: screenWidth / 5,
                          ),
                          kHeight10,
                          Text(
                            name,
                            style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Text(''),
                          kHeight10,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kDarkBlueButtonsColor,
                              ),
                              width: double.infinity,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Timing',
                                      style: GoogleFonts.outfit(
                                          color: kWhiteColor),
                                    ),
                                    Text(
                                      time,
                                      style: GoogleFonts.outfit(
                                          color: kWhiteColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          kHeight5,
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
