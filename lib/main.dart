import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project HP',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: Color(0xff159B80),
      ),
      home: SplashScreen(),
    );
  }
}
