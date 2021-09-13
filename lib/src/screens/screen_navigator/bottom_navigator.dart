import 'package:flutter/material.dart';
import 'package:project_hp/src/providers/navigator_provider/navigator_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: value.getScreenOptions.elementAt(value.getCurrentScreenIndex),
          bottomNavigationBar: value.btmNavBar(),
        );
      },
    );
  }
}
