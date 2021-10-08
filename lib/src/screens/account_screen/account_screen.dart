import 'package:flutter/material.dart';
import 'package:project_hp/src/components/alert_dialogs/alert_dialogs.dart';
import 'package:project_hp/src/components/button/main_button.dart';
import 'package:project_hp/src/components/tile_card/tag_list_card.dart';
import 'package:project_hp/src/controllers/auth_controller.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/models/user_model.dart';
import 'package:project_hp/src/screens/account_screen/components/account_screen_header.dart';
import 'package:project_hp/src/screens/account_screen/downvoted_markers_screen.dart';
import 'package:project_hp/src/screens/account_screen/user_markers_screen.dart';
import 'package:project_hp/src/screens/account_screen/upvoted_markers_screen.dart';
import 'package:project_hp/src/screens/intro_screen/intro_screen.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:project_hp/src/utils/functions.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Account',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: FutureBuilder<UserModel>(
        future: DatabaseController().getCurrentUserDetails(),
        builder: (context, snapshot) {
          UserModel? user = snapshot.data;
          if (snapshot.hasData) {
            // while data is loading:
            return user!.uid == kAnonymous
                ? AnonymouAccountContent(size: size, user: user)
                : UserAccountContent(size: size, user: user);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class AnonymouAccountContent extends StatelessWidget {
  const AnonymouAccountContent({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          AccountScreenHeader(
            user: user,
            anonymousOrNot: true,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Login for Full Access...',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(child: SizedBox()),
          MainButton(
            btnText: 'Go to Login',
            btnFunc: () => AuthController(context).signOut(),
            btnWidth: size.width,
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}

class UserAccountContent extends StatelessWidget {
  const UserAccountContent({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              AccountScreenHeader(user: user),
              SizedBox(
                height: 25,
              ),
              TagListCard(
                content: 'My Markers',
                function: () =>
                    NavigatorFuncs.navigateTo(context, UserMarkers(user: user)),
                size: size,
              ),
              TagListCard(
                content: 'Upvoted Markers',
                function: () => NavigatorFuncs.navigateTo(
                    context, UpvotedMarkers(user: user)),
                size: size,
              ),
              TagListCard(
                content: 'Downvoted Markers',
                function: () => NavigatorFuncs.navigateTo(
                    context, DownvotedMarkers(user: user)),
                size: size,
              ),
              TagListCard(
                content: 'How to use?',
                function: () =>
                    NavigatorFuncs.navigateTo(context, IntroScreen()),
                size: size,
              ),
              TagListCard(
                content: 'Log Out',
                function: () => DialogFuncs.alertDialogWithBtn(
                  context,
                  'Leaving?',
                  'Sad to see you leave!',
                  'Log Out',
                  () => AuthController(context).signOut(),
                ),
                size: size,
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
