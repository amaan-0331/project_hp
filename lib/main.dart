import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/screens/splash_screen.dart';
import 'package:project_hp/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project HP',
      theme: mainTheme,
      home: SplashScreen(),
    );
  }
}
