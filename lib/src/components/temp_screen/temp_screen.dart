import 'package:flutter/material.dart';
import 'package:project_hp/src/utils/constants.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({
    Key? key,
    required this.size,
    required this.message,
  }) : super(key: key);

  final Size size;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // UtilFuncs.pageLoader,
          CircularProgressIndicator(),
          SizedBox(
            height: kDefaultPadding * 1.5,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
