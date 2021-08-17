import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/button/text_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/controllers/auth_controller.dart';
import 'package:project_hp/screens/forgot_password/forgot_password.dart';
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
            height: 15,
          ),
          Text(
            'Hey Tourist!',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            'Signin to Continue',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 15,
          ),
          TextInput(
            lblText: 'Email',
            inputController: _email,
            inputType: TextInputType.emailAddress,
            hintText: 'someone@somewhere.com',
            validatorFunc: emailValidator(),
          ),
          TextInput(
            lblText: 'Password',
            inputController: _password,
            obscure: true,
            validatorFunc: passwordValidator(),
          ),
          isProcessing
              ? UtilFuncs.loader
              : MainButton(
                  tagName: 'logInBtn',
                  size: widget.size,
                  btnText: 'Log In',
                  btnFunc: () async {
                    if (_loginFormKey.currentState!.validate()) {
                      setState(() {
                        isProcessing = true;
                      });
                      await AuthController(context)
                          .loginUser(_email.text, _password.text);
                      setState(() {
                        isProcessing = false;
                      });
                    } else {
                      setState(() {
                        isProcessing = false;
                      });
                      DialogFuncs.alertDialog(
                          context, 'Fill Details', 'Fill all the Details');
                    }
                  },
                ),
          TextOnlyButton(
            tagName: 'forgotPasswordBtn',
            btnFunc: () {
              Logger().wtf('Dude forgot the password!!! ;))');
              NavigatorFuncs.navigateToNoBack(context, ForgotPassword());
            },
            btnText: 'Forgot Password?',
          ),
          SecondaryButton(
              tagName: 'signUpBtn',
              size: widget.size,
              btnText: 'Sign Up',
              btnFunc: () =>
                  NavigatorFuncs.navigateToNoBack(context, SignUpScreen())),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
