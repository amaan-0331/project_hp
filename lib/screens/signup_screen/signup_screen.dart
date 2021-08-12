import 'package:flutter/material.dart';
import 'package:project_hp/components/background_image.dart';
import 'package:project_hp/screens/auth_screen/signup_screen_content.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundImage(
              size: size,
              imgUrl: 'assets/images/background1.jpg',
            ),
            Column(
              children: [
                SizedBox(
                  height: size.height * 1 / 4,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  width: size.width,
                  height: size.height * 3 / 4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: SignUpContent(size: size),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
