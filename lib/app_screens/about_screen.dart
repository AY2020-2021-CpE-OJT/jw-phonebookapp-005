import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EDE7),
      appBar: AppBar(
        centerTitle: true,
        title: Text("About", style: TextStyle(color: Color(0xFF5B3415))),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 5), blurRadius: 10),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFCC13A),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icon/pb-logo-splash.png',
                            height: 60.0,
                            width: 60.0,
                          ),
                        ),
                        Text('Phonebook Application', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5B3415), fontSize: 20),),
                      ],
                    ),
                    Divider(
                      color: Color(0xFF5B3415),
                    ),
                    Text('Phonebook application that uses Flutter SDK via Android Studio IDE as a front-end. With a back-end of Node.js REST API it uses Express, Mongoose, MongoDB Atlas, Joi, CORS middleware, and JSON Web Token. It features Create, Read, Update and Delete with Authentication and Validation upon login and Creating or Updating Contacts(No UI yet). It is integrated to Cloud via Heroku.\n', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.justify,),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 5), blurRadius: 10),
                  ],
                ),
                child: Column (
                  children: [
                    Text('Developer\u0027s Note:', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5B3415), fontSize: 20),),
                    SizedBox(height: 10,),
                    Divider(
                      color: Color(0xFF5B3415),
                    ),
                    Text('This is an Application created through the series of Tasks in the OJT, Creating an application and Learning modern cross-platform technologies that enable us to broaden our knowledge in regards to software programming and development. The codes are far from perfect but tackle the required Tasks. The server-side have complete validation and authorization from creating contacts, updating contacts, login, and registration. On the client-side for creating and updating contacts, the UI output and validation are lacking. These are the Features:  ', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.justify,),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Main', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5B3415)), textAlign: TextAlign.left,),
                          SizedBox(height: 5,),
                          Text('1. Get and display All the Contacts as a list [Requires a token]', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.left,),
                          Text('2. Create New Unique(Firstname, Lastname) Contact (Working but no UI indication) [Requires a token]', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.left,),
                          Text('3. Edit Existing Contact and it retains its Uniqueness(Firstname, Lastname) (Working but no UI indication) [Requires a token]', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.left,),
                          Text('4. Delete a Specific Contact Permanently [Requires a token]', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.left,),
                          SizedBox(height: 10,),
                          Text('Login and Registration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5B3415)), textAlign: TextAlign.left,),
                          SizedBox(height: 5,),
                          Text('1. User registration have server-side and client-side validation(Unique Email and Username, Correct Inputs) and data is hashed.', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.left,),
                          Text('2. User Login is validated(Existing and Correct Email and Password, Correct Inputs) in which generates a token using JWT on the API', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.left,),
                        ],
                      ),
                    ),
                    Text('The Application uses a CRUD REST API powered by Node.js via Heroku Cloud\n', style: TextStyle(color: Color(0xFF5B3415)), textAlign: TextAlign.justify,),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 5), blurRadius: 10),
                  ],
                ),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Developed by:', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5B3415), fontSize: 20),),
                        SizedBox(height: 5,),
                        Text('John Wilbert M. Absalon', style: TextStyle(color: Color(0xFF5B3415),),),
                        Text('USLS - Computer Engineering', style: TextStyle(color: Color(0xFF5B3415),),),
                        Text('Student', style: TextStyle(color: Color(0xFF5B3415),),),
                      ],
                    ),
                    SizedBox(width: 20,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            Fluttertoast.showToast(msg: "Don\u0027t touch me uwu", toastLength: Toast.LENGTH_SHORT);
                          });
                        },
                        child: Image.asset(
                          'assets/developer-prof-pic.jpg',
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Text('2021',style: TextStyle(color: Color(0xFF5B3415),),)
            ],
          ),
        ),
      ),
    );
  }
}
