import 'package:flutter/material.dart';
import 'package:project_hp/src/screens/account_screen/account_screen.dart';
import 'package:project_hp/src/screens/nearby_screen/nearby_screen.dart';
import 'package:project_hp/src/screens/map_screen/map_screen.dart';

class NavigatorProvider extends ChangeNotifier {
  int _currentScreenIndex = 1;
  static List<Widget> _screenOptions = [
    NearByScreen(),
    MapScreen(),
    AccountScreen(),
  ];

  //getters
  int get getCurrentScreenIndex => _currentScreenIndex;
  List<Widget> get getScreenOptions => _screenOptions;

  //setters
  void setCurrentScreenIndex(int value) {
    _currentScreenIndex = value;
    notifyListeners();
  }

  //Bottom Navigation Bar for navigation
  BottomNavigationBar btmNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentScreenIndex,
      elevation: 10,
      onTap: (int value) {
        print(value);
        setCurrentScreenIndex(value);
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.5),
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(label: 'Nearby', icon: Icon(Icons.near_me)),
        BottomNavigationBarItem(label: 'Explore', icon: Icon(Icons.explore)),
        BottomNavigationBarItem(label: 'Account', icon: Icon(Icons.person)),
      ],
    );
  }
}
