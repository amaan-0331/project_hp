import 'package:flutter/material.dart';
import 'package:project_hp/src/components/shadow/boxShadow.dart';
import 'package:project_hp/src/models/user_model.dart';

class AccountScreenHeader extends StatelessWidget {
  const AccountScreenHeader({
    Key? key,
    required this.user,
    this.anonymousOrNot = false,
  }) : super(key: key);

  final UserModel user;
  final bool anonymousOrNot;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [boxShadow()],
          borderRadius: BorderRadius.circular(15)),
      currentAccountPicture: CircleAvatar(
        radius: 50,
        child: anonymousOrNot ? Icon(Icons.account_circle) : Text(user.name[0]),
      ),
      accountName: Text(
        user.name,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: Colors.black),
      ),
      accountEmail: Text(
        user.email,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
