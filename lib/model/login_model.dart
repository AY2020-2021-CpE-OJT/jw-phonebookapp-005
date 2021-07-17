class LoginResponseModel {

  String authToken;
  String error;

  LoginResponseModel({required this.authToken, required this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      authToken: json['auth-token'] != null ? json['auth-token'] : '',
      error: json['error'] != null ? json['error'] : '',
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email == null ? null : email.trim(),
      'password': password == null ? null : password.trim(),
    };
    return map;
  }
}