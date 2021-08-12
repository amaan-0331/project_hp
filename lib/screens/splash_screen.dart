import 'package:flutter/material.dart';
import 'package:project_hp/screens/auth_screen/welcome_screen.dart';
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
    navigateToHome();
  }

  void navigateToHome() {
    Future.delayed(Duration(seconds: 5), () {
      UtilFuncs.navigateTo(context, WelcomeScreen());
    });
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
