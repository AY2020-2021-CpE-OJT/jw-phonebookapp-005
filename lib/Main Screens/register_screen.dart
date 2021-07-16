import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jw_phonebookapp_005/Main%20Screens/menu_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  FocusNode nameFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    nameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).accentColor,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
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
                        child: Form(
                          key: globalFormKey,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    " Register",
                                    style: Theme.of(context).textTheme.headline2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              new TextFormField(
                                focusNode: nameFocus,
                                onTap: _requestFocusName,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.sentences,
                                //onSved:,
                                validator: (input) => input!.length < 6 ? "Name is less than 6 characters" : null,
                                decoration: new InputDecoration(
                                  //hintText: "Email Address",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).accentColor.withOpacity(0.2),
                                    ),
                                  ),
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    color: nameFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey,
                                  ),
                                  prefixIcon: Icon(Icons.account_box_rounded, color: Theme.of(context).accentColor),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              new TextFormField(
                                focusNode: emailFocus,
                                onTap: _requestFocusEmail,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                //onSved:,
                                validator: (input) => !input!.contains("@") ? "Email Address invalid" : null,
                                decoration: new InputDecoration(
                                  //hintText: "Email Address",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).accentColor.withOpacity(0.2),
                                    ),
                                  ),
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    color: emailFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey,
                                  ),
                                  prefixIcon: Icon(Icons.email, color: Theme.of(context).accentColor),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              new TextFormField(
                                focusNode: passwordFocus,
                                onTap: _requestFocusPassword,
                                keyboardType: TextInputType.text,
                                //onSved:,
                                validator: (input) => input!.length < 3 ? "Password is less than 6 characters" : null,
                                obscureText: hidePassword,
                                decoration: new InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).accentColor.withOpacity(0.2),
                                      ),
                                    ),
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      color: passwordFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey,
                                    ),
                                    prefixIcon: Icon(Icons.lock, color: Theme.of(context).accentColor),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      color: Theme.of(context).accentColor.withOpacity(0.4),
                                      icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
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
                                  onPressed: () {},
                                  child: Text(
                                    "Register",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _requestFocusName() {
    setState(() {
      FocusScope.of(context).requestFocus(nameFocus);
    });
  }

  void _requestFocusEmail() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocus);
    });
  }

  void _requestFocusPassword() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocus);
    });
  }

  Future<bool> _onBackPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text("Are you sure?",
              style: TextStyle(
                color: Color(0xFF5B3415),
                fontWeight: FontWeight.bold,
              )),
          content: const Text("Account creation will be stopped"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("CANCEL", style: TextStyle(color: Colors.redAccent))),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => MainMenu()), (_) => false);
              },
              child: const Text("CONFIRM", style: TextStyle(color: Color(0xFFFCC13A))),
            ),
          ],
        );
      },
    );
    return new Future.value(true);
  }
}
