import 'package:flutter/material.dart';
import 'package:project_hp/screens/login_screen/login_screen.dart';
import 'package:project_hp/utils/functions.dart';

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

  void navigateToNext() {
    Future.delayed(Duration(seconds: 2),
        () => NavigatorFuncs.navigateToNoBack(context, LogInScreen()));
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
