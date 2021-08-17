import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/providers/auth_providers/auth_provider.dart';
import 'package:project_hp/screens/login_screen/login_screen.dart';
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
          key: value.getFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 30,
              ),
              Text('Welcome to the Geo Tagger',
                  style: Theme.of(context).textTheme.headline1),
              SizedBox(
                height: 5,
              ),
              Text('Create an Account',
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(
                height: 30,
              ),
              TextInput(
                lblText: 'Full Name',
                hintText: 'Johnny Someone',
                inputController: value.getNameController,
              ),
              SizedBox(
                height: 15,
              ),
              TextInput(
                lblText: 'Email',
                inputType: TextInputType.emailAddress,
                hintText: 'someone@somewhere.com',
                inputController: value.getEmailController,
                validatorFunc: emailValidator(),
              ),
              SizedBox(
                height: 15,
              ),
              TextInput(
                lblText: 'Password',
                obscure: true,
                inputController: value.getPasswordController,
                validatorFunc: passwordValidator(),
              ),
              SizedBox(
                height: 15,
              ),
              value.getLoading
                  ? UtilFuncs.loader
                  : MainButton(
                      tagName: 'signUpBtn',
                      size: widget.size,
                      btnText: 'Sign Up',
                      btnFunc: () => value.startSignUpProcess(context),
                    ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('Already have an Account?',
                    style: Theme.of(context).textTheme.caption),
              ),
              SecondaryButton(
                  tagName: 'logInBtn',
                  size: widget.size,
                  btnText: 'Log In',
                  btnFunc: () =>
                      NavigatorFuncs.navigateToNoBack(context, LogInScreen())),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }
}
