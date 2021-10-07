import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/src/components/button/main_button.dart';
import 'package:project_hp/src/components/button/secondary_button.dart';
import 'package:project_hp/src/components/button/text_button.dart';
import 'package:project_hp/src/components/text_input/text_input.dart';
import 'package:project_hp/src/providers/auth_providers/auth_provider.dart';
import 'package:project_hp/src/screens/auth_screen/auth_screen.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:project_hp/src/utils/functions.dart';
import 'package:project_hp/src/utils/validator.dart';
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
              Spacer(flex: 2),
              Text(
                'Hey Tourist!',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Signin to Continue',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(flex: 2),
              FormTextInput(
                lblText: 'Email',
                inputController: value.getEmailController,
                inputAction: TextInputAction.next,
                inputType: TextInputType.emailAddress,
                hintText: 'someone@somewhere.com',
                validatorFunc: emailValidator(),
              ),
              Spacer(),
              FormTextInput(
                lblText: 'Password',
                inputAction: TextInputAction.done,
                inputController: value.getPasswordController,
                obscure: true,
                validatorFunc: passwordValidator(),
              ),
              Spacer(),
              value.getLoading
                  ? UtilFuncs.buttonLoader
                  : MainButton(
                      tagName: 'logInBtn',
                      btnText: 'Log In',
                      btnWidth: widget.size.width,
                      btnFunc: () => value.startLoginProcess(context),
                    ),
              Spacer(),
              TextOnlyButton(
                tagName: 'forgotPasswordBtn',
                btnFunc: () {
                  Logger().wtf('Dude forgot the password!!! ;))');
                  NavigatorFuncs.navigateToNoBack(context,
                      AuthScreen(userSelection: Screens.forgotPasswordScreen));
                },
                btnText: 'Forgot Password?',
              ),
              Spacer(),
              SecondaryButton(
                  tagName: 'signUpBtn',
                  size: widget.size,
                  btnText: 'Sign Up',
                  btnFunc: () => NavigatorFuncs.navigateToNoBack(context,
                      AuthScreen(userSelection: Screens.signUpScreen))),
              Spacer()
            ],
          ),
        );
      },
    );
  }
}
