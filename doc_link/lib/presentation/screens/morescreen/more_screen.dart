import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/morescreen/appointments_list/appointmentlist.dart';
import 'package:doc_link/presentation/screens/profilescreen/profilescreen.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                ],
              ),
              Center(
                child: Text(
                  'Profile',
                  style: kTextStyleLargeBlack,
                ),
              ),
              kHeight20,
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/premium-vector/avatar-portrait-kid-caucasian-boy-round-frame-vector-illustration-cartoon-flat-style_551425-43.jpg'),
                  // backgroundColor: Color.fromARGB(255, 154, 137, 81),
                ),
              ),
              kHeight10,
              Text(
                'Sufad M',
                style: kTextStyleLargeBlack,
              ),
              const SizedBox(
                height: 30,
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const AppointmentListPage();
                })),
                leading: const Icon(Icons.app_blocking_outlined),
                title: Text(
                  'Appointments',
                  style: kTextStyleMediumBlack,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const ProfileScreen();
                })),
                leading: const Icon(Icons.account_circle),
                title: Text(
                  'Edit Profile',
                  style: kTextStyleMediumBlack,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: kTextStyleMediumBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
