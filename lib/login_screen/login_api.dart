import 'dart:convert';

import 'login_response.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "http://10.0.2.2/myapi/";

Future<LoginResponse> login(String username, String password) async {
  final response = await http.post(Uri.parse("${baseUrl}login"), body: {
    "username": username,
    "password": password
  });
  return LoginResponse.fromJson(jsonDecode(response.body));
}
