import 'package:flutter/material.dart';

class AppointmentScreenStateModel extends ChangeNotifier {
  String? selectedDate;

  void setSelectedDate(String? date) {
    selectedDate = date;
    notifyListeners();
  }
}
