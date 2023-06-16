import 'GET_dept_response.dart';

class EmployeeResponse {
  bool error;
  String message;
  List<Employee> employee;

  EmployeeResponse({
    required this.error,
    required this.message,
    required this.employee,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) => EmployeeResponse(
    error: json["error"],
    message: json["message"],
    employee: List<Employee>.from(json["employee"].map((x) => Employee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "employee": List<dynamic>.from(employee.map((x) => x.toJson())),
  };
}

class Employee {
  int id;
  String fname;
  String lname;
  String email;
  String sex;
  String birthPlace;
  String birthDate;
  String joinDate;
  Dept dept;
  String address;
  int promoted;
  String username;
  String password;

  Employee({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.sex,
    required this.birthPlace,
    required this.birthDate,
    required this.joinDate,
    required this.dept,
    required this.address,
    required this.promoted,
    required this.username,
    required this.password
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    sex: json["sex"],
    birthPlace: json["birth_place"],
    birthDate: json["birth_date"],
    joinDate: json["join_date"],
    dept: Dept.fromJson(json["dept"]),
    address: json["address"],
    promoted: json["promoted"],
    username: json['username'],
    password: json['password']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fname": fname,
    "lname": lname,
    "email": email,
    "sex": sex,
    "birth_place": birthPlace,
    "birth_date": birthDate,
    "join_date": joinDate,
    "dept": dept.toJson(),
    "address": address,
    "promoted": promoted,
    "username": username,
    "password": password
  };
}

