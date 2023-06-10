import 'dart:io';
import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/profilescreen/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/elevated_button_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedGender = "Male";
  final nameofPatient = TextEditingController();
  final ageofPatient = TextEditingController();
  bool imageAlert = false;

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
                  _photo?.path == null
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
                                _photo!.path,
                              ),
                            ),
                            radius: 60,
                          ),
                        ),
                  kHeight10,
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: (Colors.black)),
                      onPressed: () {
                        getPhoto();
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
                      createRadio("Male", selectedGender, (String? value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      }),
                      const Text('Male'),
                      createRadio("Female", selectedGender, (String? value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      }),
                      const Text('Female'),
                      createRadio("Other", selectedGender, (String? value) {
                        setState(() {
                          selectedGender = value!;
                        });
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
                  //?type age-
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
  File? _photo;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      setState(
        () {
          _photo = photoTemp;
        },
      );
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
