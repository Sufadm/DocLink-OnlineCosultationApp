import 'package:flutter/cupertino.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
