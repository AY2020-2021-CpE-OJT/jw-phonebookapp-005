import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jw_phonebookapp_005/create_screens/create_contact.dart';
import 'package:jw_phonebookapp_005/update_screens/update_contact.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String authKey = '';
  var authHeaders;

  Future getAuthKeyData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var authKeyObtained = sharedPreferences.getString('authKey');
    setState(
      () {
        if (authKeyObtained != null) {
          authKey = authKeyObtained;
          authHeaders = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'auth-token': authKey.toString(),
          };
          fetchContacts(authHeaders);
        }
      },
    );
  }

  final String apiUrlget = "https://jwa-crud-api.herokuapp.com/api/posts";

  List<dynamic> _users = [];

  void fetchContacts(var authHeaders) async {
    print(authKey);
    var result = await http.get(Uri.parse(apiUrlget), headers: authHeaders);
    setState(() {
      _users = jsonDecode(result.body);
    });
    print("Status Code [" + result.statusCode.toString() + "]: All Data Fetched");
  }

  String _name(dynamic user) {
    return user['first_name'] + " " + user['last_name'];
  }

  String _phonenum(dynamic user) {
    return "Contact # " + user['phone_numbers'][0];
  }

  Future<http.Response> deleteContact(String id) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var authKeyObtained = sharedPreferences.getString('authKey');
    return http.delete(
      Uri.parse('https://jwa-crud-api.herokuapp.com/api/posts/delete/' + id),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'auth-token': authKeyObtained.toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contacts", style: TextStyle(color: Color(0xFF5B3415))),
        leading: Image.asset(
          'assets/icon/pb-logo-splash.png',
          height: 80.0,
          width: 80.0,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Color(0x805B3415),
            ),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return new AlertDialog(
                    title: const Text("Logout",
                        style: TextStyle(
                          color: Color(0xFF5B3415),
                          fontWeight: FontWeight.bold,
                        )),
                    content: const Text("Are you sure to Logout?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.remove('data');
                          sharedPreferences.remove('authKey');
                          Navigator.pushNamedAndRemoveUntil(context, '/menu', (_) => false);
                        },
                        child: const Text("LOGOUT", style: TextStyle(color: Colors.redAccent)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Color(0xFFFCC13A),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        builder: (context, snapshot) {
          return _users.length != 0
              ? RefreshIndicator(
                  color: Color(0xFFFCC13A),
                  child: ListView.builder(
                      padding: EdgeInsets.all(12.0),
                      itemCount: _users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: Key(_users[index].toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                              Icon(Icons.delete_forever, color: Colors.white70),
                              Text("Delete",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white70))
                            ]),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onDismissed: (direction) {
                            String id = _users[index]['_id'].toString();
                            String userDeleted = _users[index]['first_name'].toString();
                            deleteContact(id);
                            print("Status [Deleted]: [" + id + "]");
                            setState(() {
                              _users.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$userDeleted deleted'),
                              ),
                            );
                          },
                          confirmDismiss: (DismissDirection direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm",
                                      style: TextStyle(
                                        color: Color(0xFF5B3415),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  content: const Text("Are you sure you wish to delete this contact?"),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text("DELETE", style: TextStyle(color: Colors.redAccent))),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const Text("CANCEL", style: TextStyle(color: Color(0xFFFCC13A))),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 80,
                            color: Colors.transparent,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: index % 2 == 0 ? Color(0xFFfde09c) : Color(0xFFb7d9f3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    tileColor: Colors.transparent,
                                    selectedTileColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: index % 2 == 0 ? Color(0xBF5B3415) : Color(0x800C2F5A),
                                      radius: 30.0,
                                      child: Text(_users[index]['first_name'][0] + _users[index]['last_name'][0],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: index % 2 == 0 ? Color(0xFFFCC13A) : Color(0xFFFFFFFF),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    trailing: Icon(Icons.arrow_back_ios),
                                    title: Text(
                                      _name(_users[index]),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: index % 2 == 0 ? Color(0xFF5B3415) : Color(0xFF0C2F5A),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(_phonenum(_users[index]),
                                        style: TextStyle(
                                          color: index % 2 == 0 ? Color(0xBF5B3415) : Color(0xBF0C2F5A),
                                        )),
                                    onTap: () {
                                      List<int> listNumbers = [];
                                      for (int i = 0; i < _users[index]['phone_numbers'].length; i++) {
                                        listNumbers.add(i + 1);
                                      }
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: AlertDialog(
                                                  title: Text(
                                                    _name(_users[index]),
                                                    style: TextStyle(
                                                        color: Color(0xFF5B3415),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 24),
                                                  ),
                                                  content: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text("Contact Number/s",
                                                              style: TextStyle(
                                                                  color: Color(0xFF5B3415),
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 20)),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => UpdateContact(
                                                                        specificID: _users[index]['_id'].toString()),
                                                                  ),
                                                                  (_) => false);
                                                            },
                                                            child: const Text(
                                                              'EDIT',
                                                              style: TextStyle(
                                                                color: Color(0xFFFCC13A),
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: List.generate(
                                                            listNumbers.length,
                                                            (iter) {
                                                              return Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    'Phone #' +
                                                                        listNumbers[iter].toString() +
                                                                        ':\t\t' +
                                                                        _users[index]['phone_numbers'][iter].toString(),
                                                                    style: TextStyle(
                                                                        color: Color(0xFF5B3415), fontSize: 14),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  contentPadding: EdgeInsets.fromLTRB(24, 12, 0, 0),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context, 'OK'),
                                                      child: const Text(
                                                        'OK',
                                                        style: TextStyle(
                                                          color: Color(0xFFFCC13A),
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  actionsPadding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  onRefresh: _getData,
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFCC13A)),
                    backgroundColor: Color(0xFF5B3415),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewContact()));
        },
        child: Icon(
          Icons.add,
        ),
        foregroundColor: Color(0xFFFCC13A),
        backgroundColor: Color(0xFF5B3415),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getAuthKeyData();
  }

  Future<void> _getData() async {
    setState(() {
      getAuthKeyData();
    });
  }
}
