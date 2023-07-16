import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_link/model/user_profile.dart';
import 'package:doc_link/presentation/screens/profilescreen/widget/textformfield_widget.dart';
import 'package:doc_link/provider/profilescreenprovider.dart';
import 'package:doc_link/services/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../shared/const/const.dart';
import '../../../core/elevated_button_widgets.dart';

class ProfileScreen extends StatelessWidget {
  final String? message;
  ProfileScreen({super.key, this.message});

  final nameofPatientController = TextEditingController();

  final ageofPatientController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //   bool loading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              message!,
              style: GoogleFonts.lato(color: Colors.red),
            )),
      );
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  kHeight15,
                  //?profile pic
                  Consumer<ProfileScreenStateModel>(
                    builder: (context, state, _) {
                      return state.photo?.path == null
                          ? const Center(
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(
                                    'https://img.freepik.com/premium-vector/avatar-portrait-kid-caucasian-boy-round-frame-vector-illustration-cartoon-flat-style_551425-43.jpg'),
                                // backgroundColor: Color.fromARGB(255, 154, 137, 81),
                              ),
                            )
                          : Center(
                              child: CircleAvatar(
                                radius: 70,
                                child: ClipOval(
                                  child: SizedBox(
                                    width:
                                        160, // Adjust the width and height to your preference
                                    height: 160,
                                    child: Image.file(
                                      state.photo!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  ),

                  kHeight10,
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: (Colors.black)),
                      onPressed: () {
                        Provider.of<ProfileScreenStateModel>(context,
                                listen: false)
                            .getPhoto(context);
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                      ),
                      label: const Text(
                        'Add An Image',
                      ),
                    ),
                  ),
                  kHeight15,
                  Text(
                    'Full name',
                    style: GoogleFonts.lato(),
                  ),
                  kHeight10,
                  //?textformfield name widget----------------------------------
                  TextFormFieldName(
                    controller: nameofPatientController,
                  ),
                  kHeight20,
                  kHeight10,
                  Text(
                    'Gender',
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                  ),
                  //?radio button-
                  Row(
                    children: [
                      createRadio(
                          "Male",
                          Provider.of<ProfileScreenStateModel>(context)
                              .selectedGender, (String? value) {
                        Provider.of<ProfileScreenStateModel>(context,
                                listen: false)
                            .setSelectedGender(value!);
                      }),
                      const Text('Male'),
                      createRadio(
                          "Female",
                          Provider.of<ProfileScreenStateModel>(context)
                              .selectedGender, (String? value) {
                        Provider.of<ProfileScreenStateModel>(context,
                                listen: false)
                            .setSelectedGender(value!);
                      }),
                      const Text('Female'),
                      createRadio(
                          "Other",
                          Provider.of<ProfileScreenStateModel>(context)
                              .selectedGender, (String? value) {
                        Provider.of<ProfileScreenStateModel>(context,
                                listen: false)
                            .setSelectedGender(value!);
                      }),
                      const Text('Other'),
                    ],
                  ),
                  kHeight20,
                  Text(
                    'AGE',
                    style: GoogleFonts.lato(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  kHeight10,
                  //?textform age widget age------------------------------------
                  TextFormFieldAge(
                    controller: ageofPatientController,
                  ),
                  kHeight15,

                  Consumer<ProfileScreenStateModel>(
                    builder: (context, value, child) {
                      return value.loading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButtons(
                              text: 'Submit',
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  value.loading = true;
                                  //  Form is valid, proceed with submission
                                  String imageUrl = '';
                                  if (Provider.of<ProfileScreenStateModel>(
                                              context,
                                              listen: false)
                                          .photo !=
                                      null) {
                                    imageUrl = await UserProfileService()
                                        .uploadImageToStorage(Provider.of<
                                                    ProfileScreenStateModel>(
                                                context,
                                                listen: false)
                                            .photo!);
                                  }
                                  final fcmToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  final user = UserProfileModel(
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                    age: ageofPatientController.text,
                                    imageUrl: imageUrl,
                                    name: nameofPatientController.text,
                                    gender:
                                        Provider.of<ProfileScreenStateModel>(
                                                context,
                                                listen: false)
                                            .selectedGender,
                                    fcmToken: fcmToken!,
                                  );

                                  await UserProfileService()
                                      .getUserProfile(user)
                                      .then((_) async {
                                    // Store the FCM token in the user's document
                                    await FirebaseFirestore.instance
                                        .collection('userprofile')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({'fcmToken': fcmToken});

                                    Navigator.pop(context);
                                    value.loading = false;
                                  });
                                }
                              },
                            );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//?radio button widget-
  Radio<String> createRadio(
    String value,
    String? groupValue,
    void Function(String?) onChanged,
  ) {
    return Radio<String>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: kDarkBlueButtonsColor,
    );
  }
}
