import 'package:flutter/material.dart';
import 'package:project_hp/screens/account_screen/account_screen.dart';
import 'package:project_hp/utils/functions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Home Screen'),
              ElevatedButton(
                  onPressed: () =>
                      NavigatorFuncs.navigateTo(context, AccountScreen()),
                  child: Icon(Icons.account_circle))
            ],
          ),
        ),
      ),
    );
  }
}
