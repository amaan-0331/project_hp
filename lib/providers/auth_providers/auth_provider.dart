import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/controllers/auth_controller.dart';
import 'package:project_hp/utils/functions.dart';

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
}

class LoginProvider extends AuthProvider {
  final _loginFormKey = GlobalKey<FormState>();

  //getters
  GlobalKey<FormState> get getFormKey => _loginFormKey;

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

class SignUpProvider extends AuthProvider {
  final _signupFormKey = GlobalKey<FormState>();

  //getters
  GlobalKey<FormState> get getFormKey => _signupFormKey;

  Future<void> startSignUpProcess(BuildContext context) async {
    setLoading(true);
    if (_signupFormKey.currentState!.validate()) {
      await AuthController(context)
          .registerUser(_email.text, _password.text, _name.text);
      setLoading(false);
      DialogFuncs.snackMsg(context, 'Successful Sign Up!');
    } else {
      setLoading(false);
      DialogFuncs.alertDialog(context, 'Fill Details', 'Fill all the Details');
      DialogFuncs.snackMsg(context, 'Fill the necessary details properly!');
    }
  }
}
