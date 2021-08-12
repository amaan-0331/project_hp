import 'package:flutter/material.dart';
import 'package:project_hp/components/background_image.dart';
import 'package:project_hp/screens/auth_screen/login_screen_content.dart';
import 'package:project_hp/screens/auth_screen/signup_screen_content.dart';
import 'package:project_hp/utils/constants.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key, required this.userSelection}) : super(key: key);

  final Screens userSelection;

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
            AuthFields(nextScreen: userSelection, size: size)
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
    void screenChanger(Screens newScreen) {
      setState(() {
        nextScreen = newScreen;
      });
    }

    return Column(
      children: [
        SizedBox(
          height: (nextScreen == Screens.logInScreen)
              ? widget.size.height / 3
              : widget.size.height / 4,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: widget.size.width,
          height: (nextScreen == Screens.logInScreen)
              ? widget.size.height * 2 / 3
              : widget.size.height * 3 / 4,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: (nextScreen == Screens.logInScreen)
              ? LoginContent(
                  size: widget.size,
                )
              : SignUpContent(size: widget.size),
        ),
      ],
    );
  }
}
