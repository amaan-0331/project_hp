import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/providers/auth_providers/auth_provider.dart';
import 'package:project_hp/screens/auth_screen/auth_screen.dart';
import 'package:project_hp/utils/constants.dart';
import 'package:project_hp/utils/functions.dart';
import 'package:project_hp/utils/validator.dart';
import 'package:provider/provider.dart';

class ForgotPasswordContent extends StatefulWidget {
  const ForgotPasswordContent({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _ForgotPasswordContentState createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<ForgotPasswordContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
      builder: (context, value, child) {
        return Form(
          key: value.getForgotPasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(flex: 2),
              Text('Forgot Password?',
                  style: Theme.of(context).textTheme.headline1),
              Text('Enter Email for Password Reset Link',
                  style: Theme.of(context).textTheme.subtitle1),
              Spacer(flex: 2),
              FormTextInput(
                lblText: 'Email',
                inputController: value.getEmailController,
                inputType: TextInputType.emailAddress,
                hintText: 'someone@somewhere.com',
                validatorFunc: emailValidator(),
              ),
              Spacer(),
              value.getLoading
                  ? UtilFuncs.loader
                  : MainButton(
                      tagName: 'forgotPasswordBtn',
                      btnWidth: widget.size.width,
                      btnText: 'Send Reset Email',
                      btnFunc: () => value.startForgotPasswordProcess(context),
                    ),
              Spacer(flex: 2),
              SecondaryButton(
                  tagName: 'logInBtn',
                  size: widget.size,
                  btnText: 'Log In',
                  btnFunc: () => NavigatorFuncs.navigateToNoBack(
                      context, AuthScreen(userSelection: Screens.logInScreen))),
              Spacer(),
            ],
          ),
        );
      },
    );
  }
}
