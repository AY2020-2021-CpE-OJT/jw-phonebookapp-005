import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jw_phonebookapp_005/Main%20Screens/contacts_screen.dart';
import 'package:jw_phonebookapp_005/Main%20Screens/menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService extends StatefulWidget {
  const SharedService({Key? key}) : super(key: key);

  @override
  _SharedServiceState createState() => _SharedServiceState();
}

class _SharedServiceState extends State<SharedService> {
  late String finalEmail = '';
  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('data');
    setState(() {
      if (obtainedEmail != null) {
        finalEmail = obtainedEmail;
      }
    });
  }
  @override
  void initState() {
    getValidationData().whenComplete(() async{
      Timer(Duration(seconds: 1), () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => finalEmail.isEmpty ? MainMenu() : HomePage()),
              (_) => false));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFCC13A)),
          backgroundColor: Color(0xFF5B3415),
        ),
      ),
    );
  }
}
