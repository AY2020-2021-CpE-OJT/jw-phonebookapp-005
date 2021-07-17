import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jw_phonebookapp_005/Main%20Screens/contacts_screen.dart';
import 'package:jw_phonebookapp_005/services/shared_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Main Screens/menu_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/icon/pb-logo-splash.png"), context);
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color(0xFFFCC13A),
        accentColor: Color(0xFFFCC13A),
        textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 22.0,
              color: Color(0xFF5B3415),
            ),
            headline2: TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5B3415),
            ),
            bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFFFCC13A),
            )),
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Color(0xFFFCC13A), selectionHandleColor: Color(0xFFFCC13A), selectionColor: Color(0xABFFD36B)),
      ),
      debugShowCheckedModeBanner: false,
      home: SharedService(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new HomePage(),
        '/menu': (BuildContext context) => new MainMenu(),
      },
    );
  }
}
