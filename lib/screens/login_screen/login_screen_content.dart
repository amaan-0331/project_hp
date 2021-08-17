import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/button/text_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/providers/auth_providers/auth_provider.dart';
import 'package:project_hp/screens/forgot_password/forgot_password.dart';
import 'package:project_hp/screens/signup_screen/signup_screen.dart';
import 'package:project_hp/utils/functions.dart';
import 'package:project_hp/utils/validator.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        return Form(
          key: value.getFormKey,
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
                inputController: value.getEmailController,
                inputType: TextInputType.emailAddress,
                hintText: 'someone@somewhere.com',
                validatorFunc: emailValidator(),
              ),
              TextInput(
                lblText: 'Password',
                inputController: value.getPasswordController,
                obscure: true,
                validatorFunc: passwordValidator(),
              ),
              value.getLoading
                  ? UtilFuncs.loader
                  : MainButton(
                      tagName: 'logInBtn',
                      size: widget.size,
                      btnText: 'Log In',
                      btnFunc: () => value.startLoginProcess(context),
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
      },
    );
  }
}
