import 'dart:convert';

class LoginRequest {
  final String user;
  final String password;

  LoginRequest(this.user, this.password);

  static String toJson(LoginRequest request) {
    return jsonEncode(<String, String>{
      'user': request.user,
      'password': request.password
    });
  }
}
