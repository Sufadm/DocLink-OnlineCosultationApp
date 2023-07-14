import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenStateModel extends ChangeNotifier {
  String selectedGender = 'Male';
  String error = '';
  File? _photo;
  File? get photo => _photo;
  String? photoUrl;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setSelectedGender(String value) {
    selectedGender = value;
    notifyListeners();
  }

  void setError(String message) {
    error = message;
    notifyListeners();
  }

  Future<void> setPhoto(File? photo) async {
    _photo = photo;
    notifyListeners();
  }

  Future<void> getPhoto(BuildContext context) async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      _photo = photoTemp;
      notifyListeners();
    }
  }
}
