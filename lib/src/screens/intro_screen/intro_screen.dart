import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_hp/src/components/alert_dialogs/alert_dialogs.dart';
import 'package:project_hp/src/components/button/main_button.dart';
import 'package:project_hp/src/screens/screen_navigator/bottom_navigator.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:project_hp/src/utils/functions.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 1),
      () => DialogFuncs.snackMsg(context, 'Swipe for more!'),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> introPageItems = [
      introPageWidget(
        context,
        'Checkout Tags\naround you in\nNearby Feed!',
        'nearbyfeed.png',
      ),
      introPageWidget(
        context,
        'Checkout the explore feed\nfor more Interesting tags\nin the map!',
        'explorefeed.png',
      ),
      introPageWidget(
        context,
        'You can help\nmake tags more reliable\nby Voting on them!',
        'votingtags.png',
      ),
      introPageWidget(
        context,
        'You can share tags\nby long pressing the map\nin Explore Feed!',
        'addingtags.png',
      ),
      Center(
        child: Text(
          'Start sharing the Moment ❤\nStart enjoying the Life 🤪',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 28),
        ),
      ),
    ];

    Size size = MediaQuery.of(context).size;
    String btnText = 'Done';
    return Scaffold(
      floatingActionButton: MainButton(
        btnText: btnText,
        btnFunc: () =>
            NavigatorFuncs.navigateToNoBack(context, BottomNavigator()),
        btnWidth: size.width / 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ConcentricPageView(
        duration: Duration(seconds: 2),
        itemCount: introPageItems.length,
        curve: Curves.easeInCubic,
        physics: BouncingScrollPhysics(),
        radius: size.width,
        colors: [
          Theme.of(context).primaryColor.withOpacity(0.4),
          Theme.of(context).backgroundColor,
        ],
        itemBuilder: (index, value) {
          return introPageItems[index];
        },
      ),
    );
  }

  Widget introPageWidget(
    BuildContext context,
    String screenText,
    String imgName,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('$imageAssetpath$imgName', width: 200),
          SizedBox(height: kDefaultPadding * 1.5),
          Text(
            screenText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
