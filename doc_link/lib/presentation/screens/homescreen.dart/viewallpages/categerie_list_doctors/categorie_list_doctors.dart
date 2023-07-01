import 'package:doc_link/widgets/custom_appbar_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../../model/doctor_profile_model.dart';
import '../../../../../shared/const/const.dart';
import '../../doctors/doctors_details.dart';
import '../view_all_Doctors_page/widgets/doctors_list_widget.dart';

class CategorieListDoctors extends StatelessWidget {
  final List<ProfileModel> doctors;

  const CategorieListDoctors({Key? key, required this.doctors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: 'Category List Doctors',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: doctors.length,
          separatorBuilder: (BuildContext context, int index) => kHeight10,
          itemBuilder: (BuildContext context, int index) {
            final doctor = doctors[index];
            return DoctorsListWidget(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorsDetails(
                      profile: doctor,
                    ),
                  ),
                );
              },
              doctorname: doctor.name,
              avatarImageUrl: doctor.imageUrl,
            );
          },
        ),
      ),
    );
  }
}
