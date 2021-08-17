import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UtilFuncs {
  static Widget loader = SpinKitWave(
    type: SpinKitWaveType.start,
    color: Color(0xff159B80),
    // size: 50.0,
  );
}

class NavigatorFuncs {
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void navigateToNoBack(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }
}

//class with Dialog Functions
class DialogFuncs {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackMsg(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
}
