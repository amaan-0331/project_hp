import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UtilFuncs {
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static Widget loader = SpinKitWave(
    type: SpinKitWaveType.start,
    color: Color(0xff159B80),
    // size: 50.0,
  );
}

class DialogUtils {
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
            onPressed: () async {
              await func().then(() => Navigator.pop(context));
            },
            child: Text(btnText),
          ),
        ],
      ),
    );
  }
}
