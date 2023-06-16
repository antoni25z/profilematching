import 'dart:convert';

import 'package:gaspol/response/GET_employee_response.dart';

import '../response/GET_dept_response.dart';
import 'package:http/http.dart' as http;

import '../response/POST_default_response.dart';

const String baseUrl = "";

Future<DeptResponse> getDepts() async {
  final response = await http.get(Uri.parse("${baseUrl}dept"));
  return DeptResponse.fromJson(jsonDecode(response.body));
}

Future<EmployeeResponse> getEmployees(String employeeName) async {
  final response = await http.get(Uri.parse("${baseUrl}employees/$employeeName"));
  return EmployeeResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> addEmployee(
    Employee employee) async {
  final response = await http.post(Uri.parse("${baseUrl}add_employee"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "id": employee.id,
        "fname": employee.fname,
        "lname": employee.lname,
        "email": employee.email,
        "sex": employee.sex,
        "birth_place": employee.birthPlace,
        "birth_date": employee.birthDate,
        "join_date": employee.joinDate,
        "dept_id": employee.dept.id,
        "address": employee.address,
        "promoted": employee.promoted,
        "password": employee.password,
        "username": employee.username
      });
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> updateEmployee(
    Employee employee) async {
  final response = await http.put(Uri.parse("${baseUrl}update_employee/${employee.id}"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "fname": employee.fname,
        "lname": employee.lname,
        "email": employee.email,
        "sex": employee.sex,
        "birth_place": employee.birthPlace,
        "birth_date": employee.birthDate,
        "join_date": employee.joinDate,
        "dept_id": employee.dept.id,
        "address": employee.address,
        "promoted": employee.promoted,
        "password": employee.password,
        "username": employee.username
      });
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> deleteEmployee(int? id) async {
  final response = await http.delete(Uri.parse("${baseUrl}delete_employee/$id"));
  return DefaultResponse.fromJson(jsonDecode(response.body));
}
