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
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, value, child) {
        return Form(
          key: value.getSignUpFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(flex: 3),
              Text('Welcome to the Geo Tagger',
                  style: Theme.of(context).textTheme.headline1),
              Text('Create an Account',
                  style: Theme.of(context).textTheme.subtitle1),
              Spacer(flex: 2),
              FormTextInput(
                lblText: 'Full Name',
                hintText: 'Johnny Someone',
                inputController: value.getNameController,
              ),
              Spacer(),
              FormTextInput(
                lblText: 'Email',
                inputType: TextInputType.emailAddress,
                hintText: 'someone@somewhere.com',
                inputController: value.getEmailController,
                validatorFunc: emailValidator(),
              ),
              Spacer(),
              FormTextInput(
                lblText: 'Password',
                obscure: true,
                inputController: value.getPasswordController,
                validatorFunc: passwordValidator(),
              ),
              Spacer(),
              value.getLoading
                  ? UtilFuncs.buttonLoader
                  : MainButton(
                      tagName: 'signUpBtn',
                      btnText: 'Sign Up',
                      btnWidth: widget.size.width,
                      btnFunc: () => value.startSignUpProcess(context),
                    ),
              Spacer(flex: 2),
              Padding(
                padding: EdgeInsets.only(left: kDefaultPadding),
                child: Text('Already have an Account?',
                    style: Theme.of(context).textTheme.caption),
              ),
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
