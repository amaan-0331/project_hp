import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/screens/auth_screen/auth_screen.dart';
import 'package:project_hp/utils/constants.dart';
import 'package:project_hp/utils/functions.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          'Welcome to the Geo Tagger',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
              fontSize: 20),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Create an Account',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        SizedBox(
          height: 30,
        ),
        TextInput(
          lblText: 'Full Name',
          hintText: 'Johnny Someone',
        ),
        SizedBox(
          height: 15,
        ),
        TextInput(
          lblText: 'Email',
          hintText: 'someone@somewhere.com',
        ),
        SizedBox(
          height: 15,
        ),
        TextInput(
          lblText: 'Password',
          // hintText: '••••••••••',
          obscure: true,
        ),
        SizedBox(
          height: 15,
        ),
        // tag: 'signUpBtn',
        MainButton(
          tagName: 'signUpBtn',
          size: size,
          btnText: 'Sign Up',
          btnWidth: size.width,
          btnFunc: () {},
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          '  Already have an Account?',
          style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        SecondaryButton(
          tagName: 'logInBtn',
          size: size,
          btnText: 'Log In',
          btnFunc: () {
            UtilFuncs.navigateTo(
                context, AuthScreen(userSelection: Screens.logInScreen));
          },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
