import 'package:flutter/material.dart';
import 'package:project_hp/components/background_image.dart';
import 'package:project_hp/components/text_input/text_input.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(
            size: size,
            imgUrl: 'assets/images/background1.jpg',
          ),
          Column(
            children: [
              SizedBox(
                height: size.height / 3,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: size.width,
                  // height: size.height * 2 / 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Center(
                      child: TextInput(
                    lblText: 'Email',
                    hintText: 'someone@somewhere.com',
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
