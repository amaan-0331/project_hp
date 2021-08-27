import 'package:flutter/material.dart';
import 'package:project_hp/screens/home_screen/account_screen.dart';
import 'package:project_hp/screens/home_screen/map_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static List<Widget> _widgetOptions = [
    MapScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: btmNavBar(),
    );
  }

  BottomNavigationBar btmNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      elevation: 10,
      onTap: (int value) {
        print(value);
        setState(() {
          _currentIndex = value;
        });
      },
      backgroundColor: Colors.purple[400],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.5),
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
            label: 'Map Screen', icon: Icon(Icons.location_pin)),
        BottomNavigationBarItem(label: 'Music', icon: Icon(Icons.person)),
      ],
    );
  }
}
