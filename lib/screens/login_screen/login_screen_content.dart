import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/button/text_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/screens/signup_screen/signup_screen.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({
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
          'Hey Tourist!',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
              fontSize: 20),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          'Signin to Continue',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        SizedBox(
          height: 30,
        ),
        TextInput(
          lblText: 'Email',
          hintText: 'someone@somewhere.com',
        ),
        SizedBox(
          height: 19,
        ),
        TextInput(
          lblText: 'Password',
          // hintText: '••••••••••',
          obscure: true,
        ),
        SizedBox(
          height: 19,
        ),
        MainButton(
          tagName: 'logInBtn',
          size: size,
          btnText: 'Log In',
          btnFunc: () {},
        ),
        SizedBox(
          height: 25,
        ),
        SecondaryTextButton(
          btnFunc: () {
            print('Clicked!!!');
          },
          btnText: 'Forgot Password?',
        ),
        SizedBox(
          height: 25,
        ),
        SecondaryButton(
          tagName: 'signUpBtn',
          size: size,
          btnText: 'Sign Up',
          btnFunc: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
