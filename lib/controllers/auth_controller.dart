import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/controllers/database_controller.dart';
import 'package:project_hp/screens/home_screen/home_screen.dart';
import 'package:project_hp/utils/functions.dart';

class AuthController {
  BuildContext context;
  AuthController(this.context);

  // Firebase Auth Instance
  FirebaseAuth auth = FirebaseAuth.instance;

  //function to create user in firebase
  Future<void> registerUser(String email, password, name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await DatabaseController()
          .saveUserData(name, email, userCredential.user!.uid);
      await DialogFuncs.alertDialog(
          context, 'Success', 'User Created Successfully!');
      NavigatorFuncs.navigateToNoBack(context, HomeScreen());
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
  Future<void> loginUser(
    String email,
    password,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Logger().d('\n\n ${userCredential.user!.uid} - User Logged In! \n\n');
      await DialogFuncs.alertDialog(
          context, 'Success!', 'Login Successful! Enjoy Sharing the moment!');
      NavigatorFuncs.navigateToNoBack(context, HomeScreen());
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

//Function to send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
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
}
