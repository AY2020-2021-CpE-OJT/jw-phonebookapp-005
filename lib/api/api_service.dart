import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jw_phonebookapp_005/model/login_model.dart';

class APIService {
  var client = http.Client();

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    print(requestModel.toJson());
    String email = requestModel.email.toString();
    String password = requestModel.password.toString();
    final response = await client.post(Uri.parse('http://192.168.1.8:8080/api/user/login'),headers: <String, String>{
    "Accept": "application/json",'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {'email': email, 'password': password}));
    if (response.statusCode == 200 || response.statusCode == 400) {
      String jsonDataString = response.body.toString().replaceAll("\n","");
      print(jsonDataString);
      var _data = jsonDecode(jsonDataString);
      return LoginResponseModel.fromJson(_data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
