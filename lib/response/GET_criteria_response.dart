class CriteriaResponse {
  bool error;
  String message;
  List<Criteria> criterias;

  CriteriaResponse({
    required this.error,
    required this.message,
    required this.criterias,
  });

  factory CriteriaResponse.fromJson(Map<String, dynamic> json) => CriteriaResponse(
    error: json["error"],
    message: json["message"],
    criterias: List<Criteria>.from(json["criterias"].map((x) => Criteria.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "criterias": List<dynamic>.from(criterias.map((x) => x.toJson())),
  };
}

class Criteria {
  int id;
  String name;
  int type;
  int target;
  AspectDetail aspectDetail;
  int deptId;

  Criteria({
    required this.id,
    required this.name,
    required this.type,
    required this.target,
    required this.aspectDetail,
    required this.deptId,
  });

  factory Criteria.fromJson(Map<String, dynamic> json) => Criteria(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    target: json["target"],
    aspectDetail: AspectDetail.fromJson(json["aspect_detail"]),
    deptId: json["dept_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "target": target,
    "aspect_detail": aspectDetail.toJson(),
    "dept_id": deptId,
  };
}

class AspectDetail {
  int id;
  String name;

  AspectDetail({
    required this.id,
    required this.name,
  });

  factory AspectDetail.fromJson(Map<String, dynamic> json) => AspectDetail(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}