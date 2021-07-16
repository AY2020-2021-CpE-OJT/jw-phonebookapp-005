import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:jw_phonebookapp_005/Main%20Screens/register_screen.dart';

import 'login_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
  late DateTime currentBackPressTime;
  late Image imageLogo;
  late final _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    imageLogo = Image.asset(
      'assets/icon/pb-logo-splash.png',
      height: 200.0,
      width: 200.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeTransition(
                opacity: _animation,
                child: Column(
                  children: [
                    imageLogo,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Phonebook",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FadeTransition(
                opacity: _animation,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0, 10),
                              blurRadius: 20),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                primary: Color(0xFF5B3415), // background
                                onPrimary: Color(0xFFFCC13A), // foreground
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                  side: BorderSide(color: Color(0xFFFCC13A), width: 3),
                                ),
                                primary: Color(0xFF5B3415), // background
                                //onPrimary: Color(0xFFFCC13A), // foreground
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context, MaterialPageRoute(builder: (context) => RegisterScreen()), (_) => false);
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
