import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/button/text_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/providers/auth_providers/auth_provider.dart';
import 'package:project_hp/screens/auth_screen/auth_screen.dart';
import 'package:project_hp/utils/constants.dart';
import 'package:project_hp/utils/functions.dart';
import 'package:project_hp/utils/validator.dart';
import 'package:provider/provider.dart';

class LogInScreenContent extends StatefulWidget {
  const LogInScreenContent({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _LogInScreenContentState createState() => _LogInScreenContentState();
}

class _LogInScreenContentState extends State<LogInScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        return Form(
          key: value.getLoginFormKey,
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
                      btnText: 'Log In',
                      btnWidth: widget.size.width,
                      btnFunc: () => value.startLoginProcess(context),
                    ),
              TextOnlyButton(
                tagName: 'forgotPasswordBtn',
                btnFunc: () {
                  Logger().wtf('Dude forgot the password!!! ;))');
                  NavigatorFuncs.navigateToNoBack(context,
                      AuthScreen(userSelection: Screens.forgotPasswordScreen));
                },
                btnText: 'Forgot Password?',
              ),
              SecondaryButton(
                  tagName: 'signUpBtn',
                  size: widget.size,
                  btnText: 'Sign Up',
                  btnFunc: () => NavigatorFuncs.navigateToNoBack(context,
                      AuthScreen(userSelection: Screens.signUpScreen))),
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
