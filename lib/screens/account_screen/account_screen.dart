import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/controllers/auth_controller.dart';
import 'package:project_hp/controllers/database_controller.dart';
import 'package:project_hp/models/user_model.dart';
import 'package:project_hp/screens/account_screen/components/account_screen_header.dart';
import 'package:project_hp/utils/constants.dart';

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
        // centerTitle: true,
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
    return Center(
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
            Expanded(child: SizedBox()),
            MainButton(
              btnText: 'Sign Out',
              btnFunc: () => AuthController(context).signOut(),
              btnWidth: size.width,
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
