import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jw_phonebookapp_005/model/login_model.dart';

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

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    requestModel = new LoginRequestModel( email: '', password: '');
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                              onSaved: (input) => requestModel.password = input!,
                              validator: (input) => input!.length < 6 ? "Password is less than 6 characters" : null,
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
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (validateAndSave()) {
                                    print(requestModel.toJson());
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
                              onTap: () {},
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
              ],
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
