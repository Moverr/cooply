import 'Role.dart';

class LoginResponse{

  bool isSuccessful;
  String message;
  String auth_token;
  String refresh_token;
  List<Role> roles;

  LoginResponse({
    required this.isSuccessful,
    required this.message,
    required this.auth_token,
    required this.refresh_token,
    required this.roles,
  });







  factory LoginResponse.fromJson(Map<String, Object?> json) => LoginResponse(
    isSuccessful: json["is_successful"] as bool,
    message: json["message"] as String,
    auth_token: json["auth_token"] as String,
    refresh_token: json["refresh_token"] as String,
    roles: (json['roles'] as List).map((x) => Role.fromJson(x as Map<String, Object?>)).toList(),

    // roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_successful": isSuccessful,
    "message": message,
    "auth_token": auth_token,
    "refresh_token": refresh_token,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };



}