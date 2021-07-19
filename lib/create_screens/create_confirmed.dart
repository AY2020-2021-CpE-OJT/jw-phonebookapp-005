import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'create_contact.dart';

class CreateConfirmed extends StatelessWidget {
  final List<ContactData> todo;

  const CreateConfirmed({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<http.Response> createContact(String fname, String lname, List pnums) async {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var authKeyObtained = sharedPreferences.getString('authKey');
      return http.post(
        Uri.parse('https://jwa-crud-api.herokuapp.com/api/posts/new'),
        headers: <String, String>{
          'Content-Type': 'application/json ;charset=UTF-8',
          'Accept': 'application/json',
          'auth-token': authKeyObtained.toString(),
        },
        body: jsonEncode({
          'phone_numbers': pnums,
          'first_name': fname,
          'last_name': lname,
        }),
      );
    }

    List<int> listNumbers = [];
    for (int i = 0; i < todo[0].phoneNumbers.length; i++) {
      listNumbers.add(i + 1);
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Contact Summary')),
        ),
        body: ListView.builder(
          itemCount: todo.length,
          itemBuilder: (context, index) {
            createContact(todo[index].firstName, todo[index].lastName, todo[index].phoneNumbers);
            return Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Text('Successfully Created',
                      style: TextStyle(color: Color(0xFF3ED933), fontWeight: FontWeight.bold, fontSize: 35)),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('First Name: ',
                          style: TextStyle(color: Color(0xFF5B3415), fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Text('${todo[index].firstName}',
                          style: TextStyle(color: Color(0xFF5B3415), fontSize: 24), textAlign: TextAlign.center),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Last Name: ',
                          style: TextStyle(color: Color(0xFF5B3415), fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Text('${todo[index].lastName}',
                          style: TextStyle(color: Color(0xFF5B3415), fontSize: 24), textAlign: TextAlign.center),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Contact Numbers/s:  ',
                      style: TextStyle(color: Color(0xFF5B3415), fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      listNumbers.length,
                      (index) {
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Phone #' +
                                    listNumbers[index].toString() +
                                    ':\t\t' +
                                    todo[0].phoneNumbers[index].toString(),
                                style: TextStyle(
                                  color: Color(0xFF5B3415),
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
          },
          icon: Icon(Icons.done_all),
          label: Text("Done"),
          foregroundColor: Color(0xFFFCC13A),
          backgroundColor: Color(0xFF5B3415),
        ),
      ),
    );
  }
}
