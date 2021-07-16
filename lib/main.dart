import 'package:flutter/material.dart';

import 'Main Screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Contacts',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          accentColor: Color(0xFFFCC13A),
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 22.0, color: Color(0xFF5B3415),),
            headline2: TextStyle (
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5B3415),
            ),
            bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFFFCC13A),
            )
          ),
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: Color(0xFFFCC13A),
              selectionHandleColor: Color(0xFFFCC13A),
              selectionColor: Color(0xABFFD36B)),
        ),
        debugShowCheckedModeBanner: false,
        //
        home: LoginScreen(),
        );
  }
}
