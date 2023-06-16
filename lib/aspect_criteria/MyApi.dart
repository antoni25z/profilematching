import 'dart:convert';

import 'package:http/http.dart' as http;

import '../GET_aspect_criteria_response.dart';

const String baseUrl = "";

Future<AspectCriteriaResponse> getAspectCriteria() async {
  final response = await http.get(Uri.parse("${baseUrl}aspect_criteria"));
  return AspectCriteriaResponse.fromJson(jsonDecode(response.body));
}