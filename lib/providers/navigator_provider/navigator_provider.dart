import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/screens/account_screen/account_screen.dart';
import 'package:project_hp/screens/map_screen/map_screen.dart';
import 'package:project_hp/screens/map_screen/home_screen.dart';

class NavigatorProvider extends ChangeNotifier {
  int _currentScreenIndex = 0;
  static List<Widget> _screenOptions = [
    UpdateScreen(),
    MapScreen(),
    AccountScreen(),
  ];

  //getters
  int get getCurrentScreenIndex => _currentScreenIndex;
  List<Widget> get getScreenOptions => _screenOptions;

  //setters
  void setCurrentScreenIndex(int value) => _currentScreenIndex = value;

  //Bottom Navigation Bar for navigation
  BottomNavigationBar btmNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentScreenIndex,
      elevation: 10,
      onTap: (int value) {
        print(value);
        setCurrentScreenIndex(value);
        notifyListeners();
      },
      backgroundColor: Colors.purple[400],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.5),
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            label: 'Explore', icon: Icon(Icons.location_pin)),
        BottomNavigationBarItem(
            label: 'User Account', icon: Icon(Icons.person)),
      ],
    );
  }
}
