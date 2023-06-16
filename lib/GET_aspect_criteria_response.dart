class AspectCriteriaResponse {
  bool error;
  String message;
  List<Result> results;

  AspectCriteriaResponse({
    required this.error,
    required this.message,
    required this.results,
  });

  factory AspectCriteriaResponse.fromJson(Map<String, dynamic> json) => AspectCriteriaResponse(
    error: json["error"],
    message: json["message"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String name;
  int coreWeight;
  int secondaryWeight;
  int weight;
  List<Criterion> criteria;

  Result({
    required this.id,
    required this.name,
    required this.coreWeight,
    required this.secondaryWeight,
    required this.weight,
    required this.criteria,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    coreWeight: json["core_weight"],
    secondaryWeight: json["secondary_weight"],
    weight: json["weight"],
    criteria: List<Criterion>.from(json["criteria"].map((x) => Criterion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "core_weight": coreWeight,
    "secondary_weight": secondaryWeight,
    "weight": weight,
    "criteria": List<dynamic>.from(criteria.map((x) => x.toJson())),
  };
}

class Criterion {
  int id;
  String name;
  int type;
  int target;
  int aspectId;
  int deptId;

  Criterion({
    required this.id,
    required this.name,
    required this.type,
    required this.target,
    required this.aspectId,
    required this.deptId,
  });

  factory Criterion.fromJson(Map<String, dynamic> json) => Criterion(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    target: json["target"],
    aspectId: json["aspect_id"],
    deptId: json["dept_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "target": target,
    "aspect_id": aspectId,
    "dept_id": deptId,
  };
}