import 'dart:io';

import 'package:flutter/material.dart';

class ProfileScreenStateModel extends ChangeNotifier {
  String selectedGender = 'Male';
  File? photo;

  void setSelectedGender(String value) {
    selectedGender = value;
    notifyListeners();
  }

  void setPhoto(File? newPhoto) {
    photo = newPhoto;
    notifyListeners();
  }
}
