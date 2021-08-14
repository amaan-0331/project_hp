import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/controllers/database_controller.dart';
import 'package:project_hp/utils/functions.dart';

class AuthController {
  BuildContext context;
  AuthController(this.context);

  // Firebase Auth Instance
  FirebaseAuth auth = FirebaseAuth.instance;

  //function to create user in firebase
  Future<UserCredential?> registerUser(String email, password, name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() async {
        await DatabaseController().saveUserData(name, email);
      });
      print('\n\n ${userCredential.user!.uid} - User Created! \n\n');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogFuncs.alertDialog(
          context,
          'Weak Password',
          'The password provided is too weOak.',
          'Ok',
          false,
          () {},
        );
        print('\n\n The password provided is too weak.\n\n');
      } else if (e.code == 'email-already-in-use') {
        DialogFuncs.alertDialog(
          context,
          'Used Email',
          'The account already exists for that email.',
          'Ok',
          false,
          () {},
        );
        print('\n\nThe account already exists for that email.\n\n');
      }
    } catch (e) {
      DialogFuncs.alertDialog(
        context,
        'Error',
        e,
        'Ok',
        false,
        () {},
      );
      print(e);
    }
  }

  //function to login user in firebase
  Future<UserCredential?> loginUser(
    String email,
    password,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('\n\n ${userCredential.user!.uid} - User Logged In! \n\n');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DialogFuncs.alertDialog(
          context,
          'No User',
          'No user found for that email.',
          'Ok',
          false,
          () {},
        );
        print('\n\n No user found for that email.\n\n');
      } else if (e.code == 'wrong-password') {
        DialogFuncs.alertDialog(
          context,
          'Wrong password',
          'Wrong password provided for that user.',
          'Ok',
          false,
          () {},
        );
        print('\n\n Wrong password provided for that user.\n\n');
      }
    } catch (e) {
      DialogFuncs.alertDialog(
        context,
        'Error',
        e,
        'Ok',
        false,
        () {},
      );
      print(e);
    }
  }
}
