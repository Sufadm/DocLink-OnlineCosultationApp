//provider class----------------------------------------------------------------
import 'package:flutter/material.dart';

import '../../screens/healthtipscreen/health_tip.dart';
import '../../screens/homescreen.dart/homescreen.dart';
import '../../screens/messagescreen.dart/messagescreen.dart';
import '../../screens/morescreen/more_screen.dart';

class BottomNavState extends ChangeNotifier {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const MessageScreen(),
    const HealthTipScreen(),
    const MoreScreen(),
  ];

  int get selectedIndex => _selectedIndex;
  List<Widget> get widgetOptions => _widgetOptions;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
