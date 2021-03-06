import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/src/providers/auth_providers/auth_provider.dart';
import 'package:project_hp/src/providers/map_provider/location_provider.dart';
import 'package:project_hp/src/providers/map_provider/map_screen_provider.dart';
import 'package:project_hp/src/providers/navigator_provider/navigator_provider.dart';
import 'package:project_hp/src/screens/splash_screen/splash_screen.dart';
import 'package:project_hp/src/utils/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(allProviders());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Project HP',
      theme: mainTheme,
      home: SplashScreen(),
    );
  }
}

MultiProvider allProviders() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => LoginProvider()),
      ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => MapScreenProvider()),
      ChangeNotifierProvider(create: (context) => NavigatorProvider()),
    ],
    child: MyApp(),
  );
}
