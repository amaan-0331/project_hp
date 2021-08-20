import 'package:flutter/material.dart';
import 'package:project_hp/components/background_image.dart';
import 'package:project_hp/screens/auth_screen/forgot_password_content.dart';
import 'package:project_hp/screens/auth_screen/login_screen_content.dart';
import 'package:project_hp/screens/auth_screen/signup_screen_content.dart';
import 'package:project_hp/utils/constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
    required this.userSelection,
  }) : super(key: key);
  final Screens userSelection;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundImage(
              size: size,
              imgUrl: 'assets/images/background1.jpg',
            ),
            AuthFields(nextScreen: widget.userSelection, size: size)
          ],
        ),
      ),
    );
  }
}

class AuthFields extends StatefulWidget {
  const AuthFields({
    Key? key,
    required this.nextScreen,
    required this.size,
  }) : super(key: key);
  final Screens nextScreen;
  final Size size;

  @override
  _AuthFieldsState createState() => _AuthFieldsState();
}

class _AuthFieldsState extends State<AuthFields> {
  @override
  Widget build(BuildContext context) {
    var nextScreen = widget.nextScreen;
    return Column(
      children: [
        SizedBox(
          height: (nextScreen == Screens.signUpScreen)
              ? widget.size.height / 4
              : widget.size.height / 3,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 23),
          width: widget.size.width,
          height: (nextScreen == Screens.signUpScreen)
              ? widget.size.height * 3 / 4
              : widget.size.height * 2 / 3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: (nextScreen == Screens.signUpScreen)
              ? SignUpScreenContent(size: widget.size)
              : (nextScreen == Screens.logInScreen)
                  ? LogInScreenContent(size: widget.size)
                  : ForgotPasswordContent(size: widget.size),
        ),
      ],
    );
  }
}
