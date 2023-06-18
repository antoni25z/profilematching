class ResultRatingResponse {
  bool error;
  String message;
  List<Datum> data;

  ResultRatingResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ResultRatingResponse.fromJson(Map<String, dynamic> json) => ResultRatingResponse(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  EmployeeDetail employeeDetail;
  int result;
  int permit;
  int alpha;
  int sick;

  Datum({
    required this.id,
    required this.employeeDetail,
    required this.result,
    required this.permit,
    required this.alpha,
    required this.sick,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    employeeDetail: EmployeeDetail.fromJson(json["employee_detail"]),
    result: json["result"],
    permit: json["permit"],
    alpha: json["alpha"],
    sick: json["sick"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_detail": employeeDetail.toJson(),
    "result": result,
    "permit": permit,
    "alpha": alpha,
    "sick": sick,
  };
}

class EmployeeDetail {
  int id;
  String employeeName;

  EmployeeDetail({
    required this.id,
    required this.employeeName,
  });

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
    id: json["id"],
    employeeName: json["employee_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_name": employeeName,
  };
}