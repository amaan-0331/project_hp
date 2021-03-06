import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/src/components/alert_dialogs/alert_dialogs.dart';
import 'package:project_hp/src/controllers/auth_controller.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  //gettters
  bool get getLoading => _isLoading;
  TextEditingController get getNameController => _name;
  TextEditingController get getEmailController => _email;
  TextEditingController get getPasswordController => _password;

  //setters
  void setLoading(bool val) {
    _isLoading = val;
    Logger().i('is loading value set to $_isLoading');
    notifyListeners();
  }

  Future<void> startAnonymousLogin(BuildContext context) async {
    setLoading(true);
    await AuthController(context).signInAnonymous();
    setLoading(false);
  }
}

// Provider For Login Screen
class LoginProvider extends AuthProvider {
  final _loginFormKey = GlobalKey<FormState>();

  //getters
  GlobalKey<FormState> get getLoginFormKey => _loginFormKey;

  Future<void> startLoginProcess(BuildContext context) async {
    setLoading(true);

    if (_loginFormKey.currentState!.validate()) {
      await AuthController(context).loginUser(_email.text, _password.text);
      setLoading(false);
    } else {
      setLoading(false);
      DialogFuncs.alertDialog(context, 'Fill Details', 'Fill all the Details');
    }
  }
}

// Provider for Signup Screen
class SignUpProvider extends AuthProvider {
  final _signupFormKey = GlobalKey<FormState>();

  //getters
  GlobalKey<FormState> get getSignUpFormKey => _signupFormKey;

  Future<void> startSignUpProcess(BuildContext context) async {
    setLoading(true);
    if (_signupFormKey.currentState!.validate()) {
      await AuthController(context)
          .registerUser(_email.text, _password.text, _name.text);
      setLoading(false);
      //DialogFuncs.snackMsg(context, 'Successful Sign Up!');
    } else {
      setLoading(false);
      DialogFuncs.alertDialog(context, 'Fill Details', 'Fill all the Details');
      //DialogFuncs.snackMsg(context, 'Fill the necessary details properly!');
    }
  }
}

// Provider for Forgot password Screen
class ForgotPasswordProvider extends AuthProvider {
  final _forgotPasswordFormKey = GlobalKey<FormState>();

  //getters
  GlobalKey<FormState> get getForgotPasswordFormKey => _forgotPasswordFormKey;

  Future<void> startForgotPasswordProcess(BuildContext context) async {
    setLoading(true);

    if (_forgotPasswordFormKey.currentState!.validate()) {
      await AuthController(context).sendPasswordResetEmail(_email.text);
      setLoading(false);
    } else {
      setLoading(false);
      DialogFuncs.alertDialog(context, 'Fill Details', 'Fill all the Details');
    }
  }
}
