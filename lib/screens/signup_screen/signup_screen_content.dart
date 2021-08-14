import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/controllers/auth_controller.dart';
import 'package:project_hp/screens/home_screen/home_screen.dart';
import 'package:project_hp/screens/login_screen/login_screen.dart';
import 'package:project_hp/utils/functions.dart';
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

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();

  bool isProcessing = false;

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
            inputController: _name,
          ),
          SizedBox(
            height: 15,
          ),
          TextInput(
            lblText: 'Email',
            inputType: TextInputType.emailAddress,
            hintText: 'someone@somewhere.com',
            inputController: _email,
            validatorFunc: emailValidator(),
          ),
          SizedBox(
            height: 15,
          ),
          TextInput(
            lblText: 'Password',
            obscure: true,
            inputController: _password,
            validatorFunc: passwordValidator(),
          ),
          SizedBox(
            height: 15,
          ),
          isProcessing
              ? UtilFuncs.loader
              : MainButton(
                  tagName: 'signUpBtn',
                  size: widget.size,
                  btnText: 'Sign Up',
                  btnFunc: () async {
                    if (_signupFormKey.currentState!.validate()) {
                      setState(() {
                        isProcessing = true;
                      });
                      UserCredential? userCred =
                          await AuthController(context).registerUser(
                        _email.text,
                        _password.text,
                        _name.text,
                      );
                      if (userCred!.user == null) {
                        setState(() {
                          isProcessing = false;
                        });
                      }
                      DialogFuncs.snackMsg(context, 'Successful Sign Up!');
                      DialogFuncs.alertDialog(
                        context,
                        'Success',
                        'User Created Successfully!',
                        'ok',
                        true,
                        () {
                          NavigatorFuncs.navigateToNoBack(
                              context, HomeScreen());
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
              NavigatorFuncs.navigateToNoBack(context, LogInScreen());
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
