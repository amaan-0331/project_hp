import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/components/button/secondary_button.dart';
import 'package:project_hp/components/text_input/text_input.dart';
import 'package:project_hp/controllers/auth_controller.dart';
import 'package:project_hp/screens/login_screen/login_screen.dart';
import 'package:project_hp/utils/functions.dart';
import 'package:project_hp/utils/validator.dart';

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
  final _forgotPasswordFormKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _forgotPasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Forgot Password?',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                fontSize: 20),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Enter Email for Password Reset Link',
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
          isProcessing
              ? UtilFuncs.loader
              : MainButton(
                  tagName: 'forgotPasswordBtn',
                  size: widget.size,
                  btnText: 'Send Reset Email',
                  btnFunc: () async {
                    if (_forgotPasswordFormKey.currentState!.validate()) {
                      setState(() {
                        isProcessing = true;
                      });
                      await AuthController(context)
                          .sendPasswordResetEmail(_email.text);
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
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 25,
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
  }
}
