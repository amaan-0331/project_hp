import 'package:flutter/material.dart';

final ThemeData mainTheme = ThemeData(
  visualDensity: VisualDensity.standard,
  primarySwatch: Colors.teal,
  primaryColor: Color(0xff159B80),

  //Elevated Button Theme Data
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
          fontFamily: 'Montserrat', fontWeight: FontWeight.w800, fontSize: 18),
      primary: Color(0xff159B80),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  ),

  //Outlined Button Theme data
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    textStyle: TextStyle(
        fontFamily: 'Montserrat', fontWeight: FontWeight.w800, fontSize: 18),
    primary: Color(0xff159B80),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  )),

  //Text Button Theme Data
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.grey,
      padding: EdgeInsets.all(5),
      textStyle: TextStyle(
          fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16),
    ),
  ),

  //Text Theme
  fontFamily: 'Montserrat',
  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
    headline2: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
    ),
    headline3: TextStyle(
      fontSize: 14,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  ),

  //Text Input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 15),
    labelStyle:
        TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
    filled: false,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.transparent)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.transparent)),
  ),
);
