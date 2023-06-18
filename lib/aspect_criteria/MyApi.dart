import 'dart:convert';

import 'package:gaspol/response/GET_aspect_response.dart';
import 'package:gaspol/response/GET_criteria_response.dart';
import 'package:gaspol/response/GET_result_rating_response.dart';
import 'package:http/http.dart' as http;

import '../response/GET_aspect_criteria_response.dart';
import '../response/GET_dept_response.dart';
import '../response/GET_employee_response.dart';
import '../response/POST_default_response.dart';

const String baseUrl = "";

Future<AspectCriteriaResponse> getAspectCriteria() async {
  final response = await http.get(Uri.parse("${baseUrl}aspect_criteria"));
  return AspectCriteriaResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> addAspect(Aspect result) async {
  final response = await http.post(
      Uri.parse("${baseUrl}add_aspect"),
      body: {
        "name": result.name,
        "core_weight": result.coreWeight,
        "secondary_weight": result.secondaryWeight,
        "weight": result.weight
      }
  );
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> editAspect(Aspect result) async {
  final response = await http.put(
      Uri.parse("${baseUrl}update_aspect/${result.id}"),
      body: {
        "name": result.name,
        "core_weight": result.coreWeight,
        "secondary_weight": result.secondaryWeight,
        "weight": result.weight
      }
  );
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> deleteAspect(int id) async {
  final response = await http.delete(Uri.parse("${baseUrl}delete_aspect/$id"));
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

Future<AspectResponse> getAspects() async {
  final response = await http.get(Uri.parse("${baseUrl}aspects"));
  return AspectResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> addCriteria(Criteria result) async {
  final response = await http.post(
      Uri.parse("${baseUrl}add_criteria"),
      body: {
        "name": result.name,
        "type": result.type,
        "target": result.target,
        "aspect_id": result.aspectDetail.id,
        "dept_id": result.deptId
      }
  );
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> editCriteria(Criteria result) async {
  final response = await http.put(
      Uri.parse("${baseUrl}update_criteria/${result.id}"),
      body: {
        "name": result.name,
        "type": result.type,
        "target": result.target,
        "aspect_id": result.aspectDetail.id,
        "dept_id": result.deptId
      }
  );
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> deleteCriteria(int id) async {
  final response = await http.delete(Uri.parse("${baseUrl}delete_criteria/$id"));
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

Future<CriteriaResponse> getCriterias() async {
  final response = await http.get(Uri.parse("${baseUrl}criterias"));
  return CriteriaResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> addResultRating(int employeeId, int month, int year, double result) async {
  final response = await http.post(
    Uri.parse("${baseUrl}add_result_rating"),
      body: {
        "employee_id": employeeId,
        "month": month,
        "year": year,
        "result": result
      }
  );
  return DefaultResponse.fromJson(jsonDecode(response.body));
}

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

Future<ResultRatingResponse> getRatingResults(int year, int month) async {
  final response = await http.get(Uri.parse("${baseUrl}result_rating?year=$year&month=$month"));
  return ResultRatingResponse.fromJson(jsonDecode(response.body));
}

Future<DefaultResponse> resetPassword(String username, String oldPassword, String newPassword) async {
  final response = await http.post(
      Uri.parse("${baseUrl}reset_password"),
      body: {
        "username": username,
        "old_password": oldPassword,
        "new_password": newPassword
      }
  );
  return DefaultResponse.fromJson(jsonDecode(response.body));
}