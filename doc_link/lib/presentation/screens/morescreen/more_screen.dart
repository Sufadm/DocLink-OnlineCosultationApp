import 'package:doc_link/presentation/screens/loginscreen/login_screen.dart';
import 'package:doc_link/services/profile_service.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/presentation/screens/morescreen/appointments_list/appointmentlist.dart';
import 'package:doc_link/presentation/screens/profilescreen/profilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../model/user_profile.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<UserProfileModel>>(
            stream: UserProfileService().getAllUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userProfileList = snapshot.data!;
                if (userProfileList.isNotEmpty) {
                  final userProfile = userProfileList.first;

                  String name = ''; // Initialize with empty value
                  String imageUrl = '';
                  // final String name = userProfile.name;
                  // final String imageUrl = userProfile.imageUrl;
                  name = userProfile.name;

                  imageUrl = userProfile.imageUrl;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          'Profile',
                          style: kTextStyleLargeBlack,
                        ),
                      ),
                      kHeight20,
                      Center(
                        child: CircleAvatar(
                            radius: 70,
                            backgroundImage: imageUrl.isNotEmpty
                                ? NetworkImage(
                                    imageUrl,
                                  )
                                : null),
                      ),
                      kHeight10,
                      Text(
                        name.isNotEmpty ? name : 'No name',
                        style: kTextStyleLargeBlack,
                      ),
                      const SizedBox(height: 30),
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
                          return ProfileScreen();
                        })),
                        leading: const Icon(Icons.account_circle),
                        title: Text(
                          'Profile',
                          style: kTextStyleMediumBlack,
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      ListTile(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              'Confirmation!',
                              style: kTextStyleMediumBlack,
                            ),
                            content: Text(
                              'Do you wish to logout',
                              style: kTextStyleMediumBlack,
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: Text(
                                  'Cancel',
                                  style: kTextStyleMediumBlack,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  logout(context);
                                },
                                child: Text(
                                  'OK',
                                  style: kTextStyleMediumBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        leading: const Icon(Icons.logout),
                        title: Text(
                          'Logout',
                          style: kTextStyleMediumBlack,
                        ),
                      ),
                    ],
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }
}
