import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/screens/home_screen/home_screen.dart';
import 'package:project_hp/screens/login_screen/login_screen.dart';
import 'package:project_hp/utils/validator.dart';

class SignUpScreenContent extends StatefulWidget {
  const SignUpScreenContent({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _SignUpScreenContentState createState() => _SignUpScreenContentState();
}

class _SignUpScreenContentState extends State<SignUpScreenContent> {
  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signupFormKey,
      child: Column(
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
            validatorFunc: emailValidator(),
          ),
          SizedBox(
            height: 15,
          ),
          TextInput(
            lblText: 'Password',
            obscure: true,
            validatorFunc: passwordValidator(),
          ),
          SizedBox(
            height: 15,
          ),
          MainButton(
            tagName: 'signUpBtn',
            size: widget.size,
            btnText: 'Sign Up',
            btnFunc: () {
              if (_signupFormKey.currentState!.validate()) {
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
            size: widget.size,
            btnText: 'Log In',
            btnFunc: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInScreen()));
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
