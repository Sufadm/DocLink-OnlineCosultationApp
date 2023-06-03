import 'dart:io';
import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/loginscreen/widgets/button_widget.dart';
import 'package:doc_link/presentation/screens/profilescreen/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../mainscreen/bottomnav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameofPatient = TextEditingController();
  final ageofPatient = TextEditingController();
  bool imageAlert = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi',
                  style: GoogleFonts.lato(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                kHeight15,
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
                Row(
                  children: [
                    radio(),
                    const Text('Male'),
                    radio(),
                    const Text('Female'),
                    radio(),
                    const Text('Other')
                  ],
                ),
                kHeight20,
                Text(
                  'AGE',
                  style: GoogleFonts.lato(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                kHeight10,
                const TextFormFieldAge(),
                kHeight15,
                ElevatedButtons(
                    text: 'Submit',
                    onPressed: () {
                      // if (_formKey.currentState!.validate() && _photo != null) {
                      onStudentAddButtonClick();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const BottomNav();
                      })); // }
                      //     else {
                      //     imageAlert = true;
                      // }
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Radio<String> radio() {
    return Radio(
        value: "Male",
        groupValue: "Gender",
        onChanged: (value) {
          setState(() {}); //selected value
        });
  }

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
