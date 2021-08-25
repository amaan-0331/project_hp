import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/controllers/auth_controller.dart';
import 'package:project_hp/utils/constants.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:
            Text('User Account', style: Theme.of(context).textTheme.headline2),
        // centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello User!',
                style: Theme.of(context).textTheme.headline1,
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
      ),
    );
  }
}
