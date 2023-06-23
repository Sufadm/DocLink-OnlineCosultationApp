import 'dart:io';
import 'package:doc_link/presentation/screens/profilescreen/widget/textformfield_widget.dart';
import 'package:doc_link/provider/profilescreenprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../widgets/elevated_button_widgets.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final nameofPatient = TextEditingController();

  final ageofPatient = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                                backgroundImage: FileImage(
                                  File(
                                    state.photo!.path,
                                  ),
                                ),
                                radius: 60,
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
                        getPhoto(context);
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
                  const Text('Full name'),
                  kHeight10,
                  //?textformfield name widget----------------------------------

                  const TextFormFieldName(),
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
                  const TextFormFieldAge(),
                  kHeight15,
                  ElevatedButtons(
                      text: 'Submit',
                      onPressed: () {
                        // if (_formKey.currentState!.validate() && _photo != null) {

                        onStudentAddButtonClick();
                        Navigator.pop(context);
                        // }
                        //     else {
                        //     imageAlert = true;
                        // }
                      })
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

//?image picker method

  Future<void> getPhoto(BuildContext context) async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      // ignore: use_build_context_synchronously
      Provider.of<ProfileScreenStateModel>(context, listen: false)
          .setPhoto(photoTemp);
    }
  }

  Future<void> onStudentAddButtonClick() async {
    final name = nameofPatient.text.trim();
    final age = ageofPatient.text.trim();
    if (name.isEmpty || age.isEmpty) {
      return;
    } else {}
  }
}
