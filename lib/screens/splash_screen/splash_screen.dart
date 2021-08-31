import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/providers/map_provider/location_provider.dart';
import 'package:project_hp/screens/auth_screen/welcome_screen.dart';
import 'package:project_hp/screens/map_screen/map_screen.dart';
import 'package:project_hp/screens/screen_navigator/bottom_navigator.dart';
import 'package:project_hp/utils/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNext();
  }

  Future<void> navigateToNext() async {
    await Provider.of<LocationProvider>(context, listen: false)
        .determinePosition(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userStatus = prefs.containsKey('uid');
    Future.delayed(
      Duration(seconds: 1),
      userStatus
          ? () => NavigatorFuncs.navigateToNoBack(context, BottomNavigator())
          : () => NavigatorFuncs.navigateToNoBack(context, WelcomeScreen()),
    );
  }

  Future<void> navigateToHome() async {
    Logger().i('patangatta');
    await Provider.of<LocationProvider>(context, listen: false)
        .determinePosition(context);
    Logger().i('iwara una');

    NavigatorFuncs.navigateToNoBack(context, MapScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text(
          'ApiYamu',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
              fontSize: 20),
        )),
      ),
    );
  }
}
