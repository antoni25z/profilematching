class LoginResponse {
  bool error;
  String message;
  User? user;

  LoginResponse({
    required this.error,
    required this.message,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        error: json["error"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  int id;
  String username;
  int type;
  String dept;

  User(
      {required this.id,
      required this.username,
      required this.type,
      required this.dept});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        type: json["type"],
        dept: json["dept"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "username": username, "type": type, "dept": dept};
}
