import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jw_phonebookapp_005/services/ProgressHUD.dart';
import 'package:jw_phonebookapp_005/services/api_service.dart';
import 'package:jw_phonebookapp_005/model/login_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  late LoginRequestModel requestModel;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    requestModel = new LoginRequestModel(email: '', password: '');
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: buildUI(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget buildUI(BuildContext context) {
    Timer _timer;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 10), blurRadius: 20),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () async {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        width: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFFFCC13A),
                            ),
                            Text(
                              '  Back',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFCC13A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                " Login",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new TextFormField(
                            focusNode: emailFocus,
                            onTap: _requestFocusEmail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onSaved: (input) => requestModel.email = input!,
                            validator: (input) => !input!.contains("@") ? "Email Address invalid" : null,
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                ),
                              ),
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                color: emailFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey,
                              ),
                              prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new TextFormField(
                            focusNode: passwordFocus,
                            onTap: _requestFocusPassword,
                            keyboardType: TextInputType.text,
                            onSaved: (input) => requestModel.password = input!,
                            validator: (input) => input!.length < 6 ? "Password is less than 6 characters" : null,
                            obscureText: hidePassword,
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                ),
                              ),
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: passwordFocus.hasFocus ? Color(0xFF5B3415) : Colors.grey,
                              ),
                              prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Theme.of(context).primaryColor.withOpacity(0.4),
                                icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
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
                              onPressed: () async {
                                _timer = Timer(Duration(seconds: 20), () {
                                  setState(
                                    () {
                                      isApiCallProcess = false;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return new AlertDialog(
                                            title: Row(
                                              children: [
                                                Icon(
                                                  Icons.error,
                                                  color: Colors.redAccent,
                                                ),
                                                Text(
                                                  "  Unexpected Error",
                                                  style: TextStyle(
                                                    color: Color(0xFF5B3415),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            content: Text('Connection Timeout [@_@]: Check your Internet Connection',
                                                textAlign: TextAlign.left),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("OK", style: TextStyle(color: Color(0xFFFCC13A)))),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                });
                                if (validateAndSave() == false){
                                  _timer.cancel();
                                }
                                FocusManager.instance.primaryFocus?.unfocus();
                                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                if (validateAndSave()) {
                                  setState(() {
                                    isApiCallProcess = true;
                                  });
                                  APIService apiService = new APIService();
                                  apiService.login(requestModel).then(
                                    (value) {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                      if (value.authToken.isNotEmpty) {
                                        _timer.cancel();
                                        sharedPreferences.setString('data', requestModel.toJson().toString());
                                        sharedPreferences.setString('authKey', value.authToken.toString());
                                        sharedPreferences.setString('currentUser', value.message.toString());
                                        sharedPreferences.setString('currentEmail', requestModel.email.toString());
                                        globalFormKey.currentState!.reset();
                                        Fluttertoast.showToast(msg: "Login Successful");
                                        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                                      } else {
                                        _timer.cancel();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return new AlertDialog(
                                              title: Row(
                                                children: [
                                                  Icon(
                                                    Icons.error,
                                                    color: Colors.redAccent,
                                                  ),
                                                  Text(
                                                    "  Login",
                                                    style: TextStyle(
                                                      color: Color(0xFF5B3415),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              content: new Text(value.error),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child:
                                                        const Text("OK", style: TextStyle(color: Color(0xFFFCC13A)))),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                  );
                                }
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
                          new GestureDetector(
                            onTap: () {
                              setState(() {
                                Fluttertoast.showToast(msg: "Feature [Forgot Password] not yet Integrated");
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom: 5, // Space between underline and text
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.amber,
                                width: 2.0, // Underline thickness
                              ))),
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(color: Color(0xFFFCC13A), fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
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
}
