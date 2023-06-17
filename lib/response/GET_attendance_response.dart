class AttendanceResponse {
  bool error;
  String message;
  List<Attendance> attendance;

  AttendanceResponse({
    required this.error,
    required this.message,
    required this.attendance,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) => AttendanceResponse(
    error: json["error"],
    message: json["message"],
    attendance: List<Attendance>.from(json["attendance"].map((x) => Attendance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
  };
}

class Attendance {
  int id;
  Employee employee;
  int permit;
  int alpha;
  int sick;

  Attendance({
    required this.id,
    required this.employee,
    required this.permit,
    required this.alpha,
    required this.sick,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["id"],
    employee: Employee.fromJson(json["employee"]),
    permit: json["permit"],
    alpha: json["alpha"],
    sick: json["sick"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee": employee.toJson(),
    "permit": permit,
    "alpha": alpha,
    "sick": sick,
  };
}

class Employee {
  int id;
  String employeeName;

  Employee({
    required this.id,
    required this.employeeName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    employeeName: json["employee_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_name": employeeName,
  };
}
