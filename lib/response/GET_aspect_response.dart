class AspectResponse {
  bool error;
  String message;
  List<Aspect> aspects;

  AspectResponse({
    required this.error,
    required this.message,
    required this.aspects,
  });

  factory AspectResponse.fromJson(Map<String, dynamic> json) => AspectResponse(
    error: json["error"],
    message: json["message"],
    aspects: List<Aspect>.from(json["aspects"].map((x) => Aspect.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "aspects": List<dynamic>.from(aspects.map((x) => x.toJson())),
  };
}

class Aspect {
  int id;
  String name;
  int coreWeight;
  int secondaryWeight;
  int weight;

  Aspect({
    required this.id,
    required this.name,
    required this.coreWeight,
    required this.secondaryWeight,
    required this.weight,
  });

  factory Aspect.fromJson(Map<String, dynamic> json) => Aspect(
    id: json["id"],
    name: json["name"],
    coreWeight: json["core_weight"],
    secondaryWeight: json["secondary_weight"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "core_weight": coreWeight,
    "secondary_weight": secondaryWeight,
    "weight": weight,
  };
}