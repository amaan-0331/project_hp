import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/src/components/alert_dialogs/alert_dialogs.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/providers/navigator_provider/navigator_provider.dart';
import 'package:project_hp/src/screens/auth_screen/auth_screen.dart';
import 'package:project_hp/src/screens/auth_screen/welcome_screen.dart';
import 'package:project_hp/src/screens/screen_navigator/bottom_navigator.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:project_hp/src/utils/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  BuildContext context;
  AuthController(this.context);

  // Firebase Auth Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //function to create user in firebase
  Future<void> registerUser(String email, password, name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //
      await DatabaseController()
          .saveUserData(name, email, userCredential.user!.uid);

      //sending user an email verification link
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      //Navigating...
      NavigatorFuncs.navigateToNoBack(
          context, AuthScreen(userSelection: Screens.logInScreen));

      //Letting the user know
      await DialogFuncs.alertDialog(context, 'Success',
          'Check your email and Verify your Email. Then you can Login!');
      Logger().d('\n\n ${userCredential.user!.uid} - User Created! \n\n');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogFuncs.alertDialog(
            context, 'Weak Password', 'The password provided is too weOak.');
        Logger().e('\n\n The password provided is too weak.\n\n');
      } else if (e.code == 'email-already-in-use') {
        DialogFuncs.alertDialog(context, 'Used Email',
            'The account already exists for that email.');
        Logger().e('\n\nThe account already exists for that email.\n\n');
      } else {
        DialogFuncs.alertDialog(context, 'Error', e.message);
        Logger().e(e.message);
      }
    } catch (e) {
      DialogFuncs.alertDialog(context, 'Error', e);
      Logger().e(e);
    }
  }

  //function to login user in firebase
  Future<void> loginUser(String email, password) async {
    try {
      //Logics
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;

      //checking if the user email is verified
      if (user!.emailVerified) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('uid', userCredential.user!.uid);

        Logger().d('\n\n ${userCredential.user!.uid} - User Logged In! \n\n');

        //Navigating...
        Provider.of<NavigatorProvider>(context, listen: false)
            .setCurrentScreenIndex(0);
        NavigatorFuncs.navigateToNoBack(context, BottomNavigator());

        //Letting the user know
        DialogFuncs.alertDialog(
            context, 'Success!', 'Login Successful! Enjoy Sharing the moment!');
      } else {
        //Letting the user know
        DialogFuncs.alertDialogWithBtn(
          context,
          'Need Email verification!',
          'Check the Email Address and Verify your Email Account',
          'Get Link Again',
          () async => await user.sendEmailVerification(),
        );
        //removing user login if email is not verified
        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DialogFuncs.alertDialog(
            context, 'No User', 'No user found for that email.');
        Logger().e('\n\n No user found for that email.\n\n');
      } else if (e.code == 'wrong-password') {
        DialogFuncs.alertDialog(context, 'Wrong password',
            'Wrong password provided for that user.');
        Logger().e('\n\n Wrong password provided for that user.\n\n');
      } else {
        DialogFuncs.alertDialog(context, 'Error', e.message);
        Logger().e(e.message);
      }
    } catch (e) {
      DialogFuncs.alertDialog(context, 'Error', e);
      Logger().e(e);
    }
  }

  //Function to Anonymous SignIn
  Future<void> signInAnonymous() async {
    try {
      //Logics
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', kAnonymous);

      //Navigating...
      Provider.of<NavigatorProvider>(context, listen: false)
          .setCurrentScreenIndex(0);
      NavigatorFuncs.navigateToNoBack(context, BottomNavigator());

      //Letting the user know
      Logger().d('\n\n Anonymously LoggedIn! \n\n');
      await DialogFuncs.alertDialog(context, 'Sneaky😜!',
          'Logged In without Authentication! Enjoy Sharing the moment!');
    } catch (e) {
      DialogFuncs.alertDialog(context, 'Error', e.toString());
      Logger().e(e.toString());
    }
  }

  //Function to send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      //logic
      await _auth.sendPasswordResetEmail(email: email);

      //Letting the user know
      DialogFuncs.alertDialog(
          context, 'Success', 'Successfully Password Reset mail sent.');
      Logger().i('Password Reset mail sent');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DialogFuncs.alertDialog(
            context, 'No User', 'No user found for that email.');
        Logger().e('\n\n No user found for that email.\n\n');
      } else {
        DialogFuncs.alertDialog(context, 'Error', e.message);
        Logger().e(e.message);
      }
    } catch (e) {
      DialogFuncs.alertDialog(context, 'Error', e);
      Logger().e(e);
    }
  }

  //Function to signout
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    prefs.setString('uid', kAnonymous);
    if (uid != kAnonymous) {
      await DialogFuncs.alertDialog(
          context, 'Success!', 'Log Out Successful! Sad to see you leave!');
    }

    //Navigating...
    NavigatorFuncs.navigateToNoBack(context, WelcomeScreen());
  }
}
