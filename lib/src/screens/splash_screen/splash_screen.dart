import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/providers/map_provider/location_provider.dart';
import 'package:project_hp/src/screens/auth_screen/welcome_screen.dart';
import 'package:project_hp/src/screens/intro_screen/intro_screen.dart';
import 'package:project_hp/src/screens/screen_navigator/bottom_navigator.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:project_hp/src/utils/functions.dart';
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
    await Provider.of<LocationProvider>(context, listen: false).determinePosition(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('uid')) {
      prefs.setString('uid', kAnonymous);
    }
    if (!prefs.containsKey('introSeen')) {
      prefs.setBool('introSeen', false);
    }
    Logger().d('uid from splashscreen preference is ' + prefs.getString('uid')!);
    Future.delayed(
      Duration(seconds: 1),
      (prefs.getString('uid') == kAnonymous)
          ? () => NavigatorFuncs.navigateToNoBack(context, WelcomeScreen())
          : (prefs.getBool('introSeen') == true)
              ? () => NavigatorFuncs.navigateToNoBack(context, BottomNavigator())
              : () {
                  DatabaseController().updateIntroStatusInUserData(prefs.getString('uid')!, true);
                  prefs.setBool('introSeen', true);
                  NavigatorFuncs.navigateToNoBack(context, IntroScreen());
                },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              '${imageAssetpath}logo.png',
              height: size.height / 4,
            ),
            SizedBox(height: size.height / 10),
            Text('ApiYamu', style: Theme.of(context).textTheme.headline1)
          ],
        ),
      ),
    );
  }
}
