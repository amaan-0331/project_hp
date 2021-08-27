import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_hp/components/text_input/text_input.dart';

class UtilFuncs {
  static Widget loader = SpinKitWave(
    type: SpinKitWaveType.start,
    color: Color(0xff159B80),
    // size: 50.0,
  );
}

//Functions to navigate across the screens
class NavigatorFuncs {
  //Function to Navigate with push
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  //Function to Navigate with pushAndRemoveUntil
  static void navigateToNoBack(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }
}

//class with Dialog Functions
class DialogFuncs {
  //Snack message function
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackMsg(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  //Alert Dialog Function
  static Future<String?> alertDialog(
    BuildContext context,
    String title,
    description,
  ) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  //Alert Dialog Function with additional function
  static Future<String?> alertDialogWithBtn(
    BuildContext context,
    String title,
    description,
    btnText,
    Function func,
  ) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              func();
              Navigator.pop(context);
            },
            child: Text(btnText),
          ),
        ],
      ),
    );
  }

  //Alert Dialog Function with two additional functions
  static Future<String?> alertDialogWithTwoBtn(
    BuildContext context,
    String title,
    description,
    String btnText1,
    Function func1,
    String btnText2,
    Function func2,
  ) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              func1();
              Navigator.pop(context);
            },
            child: Text(btnText1),
          ),
          TextButton(
            onPressed: () {
              func2();
              Navigator.pop(context);
            },
            child: Text(btnText2),
          ),
        ],
      ),
    );
  }

  //Alert Dialog Function with two additional functions
  static Future<String?> alertDialogWithTextFields(
    BuildContext context,
    String title,
    description,
    TextEditingController titleController,
    snippetController,
  ) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        elevation: 15,
        // shape: RoundedRectangleBorder(side: BorderSide(width: 500)),
        titlePadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        insetPadding: EdgeInsets.all(25),
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        title: Text(title),
        content: Container(
          height: 200,
          child: Column(
            children: [
              Text(description),
              SizedBox(height: 20),
              NormalTextInput(
                lblText: 'Title',
                inputController: titleController,
              ),
              SizedBox(height: 20),
              NormalTextInput(
                lblText: 'Snippet',
                inputController: snippetController,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }
}
