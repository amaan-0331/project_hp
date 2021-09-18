import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_hp/src/components/button/icon_button.dart';
import 'package:project_hp/src/components/text_input/text_input.dart';
import 'package:project_hp/src/utils/constants.dart';

class UtilFuncs {
  //Loader animation when button loading
  static Widget buttonLoader = SpinKitWave(
    type: SpinKitWaveType.start,
    color: Color(0xff159B80),
    // size: 50.0,
  );

  //Loader animation when page loading
  static Widget pageLoader = SpinKitChasingDots(
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

  //Alert Dialog Function with two additional functions //not used
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

  //Alert Dialog Function with textfields
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
        titlePadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        insetPadding: EdgeInsets.all(25),
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        title: Text(title),
        content: SingleChildScrollView(
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

  //Alert Dialog Function
  static Future<String?> alertDialogForMarker(
    BuildContext context,
    String infoTitle,
    String infoSnippet,
    VoteStatus userVoteStatus,
    int markerVoteCount,
    Function upvoteBtnFunc,
    Function downvoteBtnFunc,
  ) {
    int voteCount = markerVoteCount;
    VoteStatus voteStatus = userVoteStatus;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text(infoTitle),
              content: Text(infoSnippet),
              actions: <Widget>[
                IconOnlyButton(
                  btnIcon: Icon(Icons.arrow_upward),
                  btnHeight: 15,
                  btnColor: voteStatus == VoteStatus.upvoted
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  btnFunc: () {
                    upvoteBtnFunc();
                    setState(() {
                      if (voteStatus == VoteStatus.upvoted) {
                        voteCount--;
                        voteStatus = VoteStatus.notVoted;
                      } else if (voteStatus == VoteStatus.downvoted) {
                        voteCount = voteCount + 2;
                        voteStatus = VoteStatus.upvoted;
                      } else {
                        voteCount++;
                        voteStatus = VoteStatus.upvoted;
                      }
                    });
                  },
                ),
                Text(
                  voteCount.toString(),
                  style: Theme.of(context).textTheme.headline1,
                ),
                IconOnlyButton(
                  btnIcon: Icon(Icons.arrow_downward),
                  btnHeight: 15,
                  btnColor: voteStatus == VoteStatus.downvoted
                      ? Colors.redAccent
                      : Colors.grey,
                  btnFunc: () {
                    downvoteBtnFunc();
                    setState(() {
                      if (voteStatus == VoteStatus.downvoted) {
                        voteCount++;
                        voteStatus = VoteStatus.notVoted;
                      } else if (voteStatus == VoteStatus.upvoted) {
                        voteCount = voteCount - 2;
                        voteStatus = VoteStatus.downvoted;
                      } else {
                        voteCount--;
                        voteStatus = VoteStatus.downvoted;
                      }
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}