class DeptResponse {
  bool error;
  String message;
  List<Dept> dept;

  DeptResponse({
    required this.error,
    required this.message,
    required this.dept,
  });

  factory DeptResponse.fromJson(Map<String, dynamic> json) => DeptResponse(
    error: json["error"],
    message: json["message"],
    dept: List<Dept>.from(json["dept"].map((x) => Dept.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "dept": List<dynamic>.from(dept.map((x) => x.toJson())),
  };
}

class Dept {
  int id;
  String deptName;

  Dept({
    required this.id,
    required this.deptName,
  });

  factory Dept.fromJson(Map<String, dynamic> json) => Dept(
    id: json["id"],
    deptName: json["dept_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dept_name": deptName,
  };
}