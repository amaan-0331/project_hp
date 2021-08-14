import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/button/text_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/controllers/auth_controller.dart';
import 'package:project_hp/screens/home_screen/home_screen.dart';
import 'package:project_hp/screens/signup_screen/signup_screen.dart';
import 'package:project_hp/utils/functions.dart';
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

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isProcessing = false;

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
            inputController: _email,
            inputType: TextInputType.emailAddress,
            hintText: 'someone@somewhere.com',
            validatorFunc: emailValidator(),
          ),
          SizedBox(
            height: 19,
          ),
          TextInput(
            lblText: 'Password',
            inputController: _password,
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
            btnFunc: () async {
              if (_loginFormKey.currentState!.validate()) {
                setState(() {
                  isProcessing = true;
                });
                UserCredential? userCred =
                    await AuthController(context).loginUser(
                  _email.text,
                  _password.text,
                );
                if (userCred!.user != null) {
                  setState(() {
                    isProcessing = false;
                  });
                }
                // DialogUtils.snackMsg(context, 'Successful Login!');
                DialogFuncs.alertDialog(
                  context,
                  'Success!',
                  'Login Successful! Enjoy Sharing the moment!',
                  'ok',
                  true,
                  () {
                    NavigatorFuncs.navigateToNoBack(context, HomeScreen());
                  },
                );
              } else {
                setState(() {
                  isProcessing = false;
                });
                DialogFuncs.alertDialog(
                  context,
                  'Fill Details',
                  'Fill all the Details',
                  'Ok',
                  false,
                  () {},
                );
                DialogFuncs.snackMsg(
                    context, 'Fill the necessary details properly!');
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
              NavigatorFuncs.navigateToNoBack(context, SignUpScreen());
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
