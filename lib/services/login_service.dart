import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_menu/models/base/api_response.dart';
import 'package:flutter_menu/models/login/login_request.dart';

import '../models/login/access_token.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse<AccessToken>> login(LoginRequest request) async {
  final response = await http.post(
    Uri.parse('https://10.0.2.2:5001/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: LoginRequest.toJson(request),
  );

  String errorMessage;

  switch (response.statusCode) {
    case 200:
      return ApiResponse.success(data: AccessToken.fromJson(jsonDecode(response.body)));
    case 400:
      errorMessage = 'Error ao realizar login';
      break;
    case 500:
      errorMessage = 'Erro desconhecido';
      break;
    default:
      errorMessage = 'Credenciais inválidas';
  }

  log(response.body);

  return ApiResponse.error(apiError: errorMessage);
}
