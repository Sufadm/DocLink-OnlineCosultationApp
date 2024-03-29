import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/services/profile_service.dart';
import 'package:doc_link/shared/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../loginscreen/login_screen.dart';
import '../profilescreen/profilescreen.dart';
import 'appointments_list/appointmentlist.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: UserProfileService().getAllUserProfile(),
            builder: (context, snapshot) {
              final hasData = snapshot.hasData && snapshot.data?.exists == true;
              final document = hasData ? snapshot.data! : null;
              final imageUrl = document?['imageUrl'] ??
                  'https://img.freepik.com/premium-vector/avatar-portrait-kid-caucasian-boy-round-frame-vector-illustration-cartoon-flat-style_551425-43.jpg';
              final name = document?['name'] ?? 'No Name';

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
                      radius: screenWidth * 0.18,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                  kHeight10,
                  Text(
                    name,
                    style: kTextStyleLargeBlack,
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    ),
                    leading: const Icon(
                      Icons.account_circle,
                      color: kBlackColor,
                    ),
                    title: Text(
                      'Create Profile',
                      style: kTextStyleMediumBlack,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: kBlackColor,
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppointmentListPage()),
                    ),
                    leading: const Icon(
                      Icons.app_blocking_outlined,
                      color: kBlackColor,
                    ),
                    title: Text(
                      'Appointments',
                      style: kTextStyleMediumBlack,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: kBlackColor,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      const url =
                          'mailto:sufadzan1@gmail.com?subject=Help me&body=How Can I Help You';
                      Uri uri = Uri.parse(url);

                      await launchUrl(uri);
                    },
                    leading: const Icon(
                      Icons.app_blocking_outlined,
                      color: kBlackColor,
                    ),
                    title: Text(
                      'Feedback',
                      style: kTextStyleMediumBlack,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: kBlackColor,
                    ),
                  ),
                  ListTile(
                    onTap: () => shareApp(),
                    leading: const Icon(
                      Icons.share,
                      color: kBlackColor,
                    ),
                    title: Text(
                      'Invite Friends',
                      style: kTextStyleMediumBlack,
                    ),
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
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: Text(
                              'Cancel',
                              style: kTextStyleMediumBlack,
                            ),
                          ),
                          TextButton(
                            onPressed: () => logout(context),
                            child: Text(
                              'OK',
                              style: kTextStyleMediumBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    leading: const Icon(
                      Icons.logout,
                      color: kBlackColor,
                    ),
                    title: Text(
                      'Logout',
                      style: kTextStyleMediumBlack,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

//?Share app function-----------------------------------------------------------
Future<void> shareApp() async {
  // Set the app link and the message to be shared
  const String appLink =
      'https://play.google.com/store/apps/details?id=in.sufadzan.doc_link';
  const String message = 'Check out my new app: $appLink';

  // Share the app link and message using the share dialog
  await FlutterShare.share(title: 'Share App', text: message, linkUrl: appLink);
}

void logout(BuildContext context) {
  FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
}
