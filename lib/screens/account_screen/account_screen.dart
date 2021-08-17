import 'package:flutter/material.dart';
import 'package:project_hp/components/button/main_button.dart';
import 'package:project_hp/controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Hello User!',
                style: Theme.of(context).textTheme.headline1,
              ),
              MainButton(
                btnText: 'Sign Out',
                btnFunc: () => AuthController(context).signOut(),
                btnWidth: size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
