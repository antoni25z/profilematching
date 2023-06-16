import 'dart:convert';

import 'login_response.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "";

Future<LoginResponse> login(String username, String password) async {
  final response = await http.post(Uri.parse("${baseUrl}login"));
  return LoginResponse.fromJson(jsonDecode(response.body));
}