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




  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    isSuccessful: json["is_successful"],
    message: json["message"],
    auth_token: json["auth_token"],
    refresh_token: json["refresh_token"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_successful": isSuccessful,
    "message": message,
    "auth_token": auth_token,
    "refresh_token": refresh_token,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };



}