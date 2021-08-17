import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/screens/auth_screen/auth_screen.dart';
import 'package:project_hp/utils/constants.dart';
import 'package:project_hp/utils/functions.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start Exploring the World',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Start Sharing the Moment',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainButton(
                    tagName: 'logInBtn',
                    btnText: 'Log In',
                    btnWidth: size.width * 2 / 5,
                    btnFunc: () => NavigatorFuncs.navigateTo(context,
                        AuthScreen(userSelection: Screens.logInScreen))),
                MainButton(
                    tagName: 'signUpBtn',
                    btnText: 'Sign Up',
                    btnWidth: size.width * 2 / 5,
                    btnFunc: () => NavigatorFuncs.navigateTo(context,
                        AuthScreen(userSelection: Screens.signUpScreen))),
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
