import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/button/text_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/screens/home_screen/home_screen.dart';
import 'package:project_hp/screens/signup_screen/signup_screen.dart';
import 'package:project_hp/utils/validator.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
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
            validatorFunc: emailValidator(),
          ),
          SizedBox(
            height: 19,
          ),
          TextInput(
            lblText: 'Password',
            obscure: true,
            validatorFunc: passwordValidator(),
          ),
          SizedBox(
            height: 19,
          ),
          MainButton(
            tagName: 'logInBtn',
            size: widget.size,
            btnText: 'Log In',
            btnFunc: () {
              if (_loginFormKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Successful Login!')),
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Fill the necessary details properly!')),
                );
              }
            },
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
            size: widget.size,
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
      ),
    );
  }
}
