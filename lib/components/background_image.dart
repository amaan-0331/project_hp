import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.size,
    required this.imgUrl,
  }) : super(key: key);

  final Size size;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height / 2.5,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(imgUrl),
        fit: BoxFit.cover,
      )),
    );
  }
}
