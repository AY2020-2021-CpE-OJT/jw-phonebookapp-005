import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  final String currentUser;
  const AccountScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState(currentUser);
}

class _AccountScreenState extends State<AccountScreen> {
  String currentUser;
  _AccountScreenState(this.currentUser);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(currentUser)),
    );
  }

}
