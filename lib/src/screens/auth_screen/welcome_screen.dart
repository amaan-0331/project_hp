import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_hp/src/components/button/main_button.dart';
import 'package:project_hp/src/components/button/secondary_button.dart';
import 'package:project_hp/src/providers/auth_providers/auth_provider.dart';
import 'package:project_hp/src/screens/auth_screen/auth_screen.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:project_hp/src/utils/functions.dart';
import 'package:provider/provider.dart';

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
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Lottie.asset(
              'assets/lottie/traveler.json',
              errorBuilder: (context, error, stackTrace) => SizedBox(),
              repeat: true,
              animate: true,
            ),
            SizedBox(height: kDefaultPadding - 5),
            Text(
              'Start Exploring the World',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              'Start Sharing the Moment',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainButton(
                    tagName: 'logInBtn',
                    btnText: 'Log In',
                    btnWidth: size.width * 2 / 5,
                    btnFunc: () => NavigatorFuncs.navigateTo(
                        context, AuthScreen(userSelection: Screens.logInScreen))),
                MainButton(
                    tagName: 'signUpBtn',
                    btnText: 'Sign Up',
                    btnWidth: size.width * 2 / 5,
                    btnFunc: () => NavigatorFuncs.navigateTo(
                        context, AuthScreen(userSelection: Screens.signUpScreen))),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Consumer<AuthProvider>(
              builder: (context, value, child) {
                return value.getLoading
                    ? UtilFuncs.buttonLoader
                    : SecondaryButton(
                        size: size,
                        btnText: 'Guest Mode',
                        btnFunc: () => Provider.of<AuthProvider>(context, listen: false)
                            .startAnonymousLogin(context),
                      );
              },
            ),
            SizedBox(height: kDefaultPadding * 2.5),
          ],
        ),
      ),
    );
  }
}
