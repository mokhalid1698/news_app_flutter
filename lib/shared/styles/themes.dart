import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black26,
  primarySwatch: Colors.teal,
  disabledColor: Colors.white60,
  inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      disabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(),
      )),
  appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light)),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 16, overflow: TextOverflow.ellipsis,
        color: Colors.white,
        // fontSize: 40,
        // fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 10, overflow: TextOverflow.ellipsis,
        color: Colors.white,
        // fontSize: 40,
        // fontWeight: FontWeight.bold,
      ),
      headline1: TextStyle(
        fontSize: 14,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
      )),
);
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade300,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.teal,
    unselectedItemColor: Colors.black45,
    showUnselectedLabels: true
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      disabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(),
      )),
  primarySwatch: Colors.teal,
  appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  textTheme: const TextTheme(
      bodyText2: TextStyle(
        fontSize: 10, overflow: TextOverflow.ellipsis,
        color: Colors.black,
        // fontSize: 40,
        // fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis
          // color: Colors.white,
          // fontSize: 40,
          // fontWeight: FontWeight.bold,
          ),
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 14,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
      )
  ,headline4: TextStyle(
    fontSize: 60
  )

  ),
);
