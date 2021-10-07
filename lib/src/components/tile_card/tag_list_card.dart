import 'package:flutter/material.dart';
import 'package:project_hp/src/utils/constants.dart';

class TagListCard extends StatelessWidget {
  const TagListCard({
    Key? key,
    required this.content,
    required this.function,
    required this.size,
  }) : super(key: key);

  final String content;
  final Function() function;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding / 8),
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: ListTile(
          onTap: function,
          title: Text(
            content,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}
