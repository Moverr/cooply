import 'Role.dart';

class LoginResponse{

  bool isSuccessful;
  String message;
  String authToken;
  String refreshToken;
  List<Role> roles;

  LoginResponse({
    required this.isSuccessful,
    required this.message,
    required this.authToken,
    required this.refreshToken,
    required this.roles,
  });


  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    isSuccessful: json["is_successful"],
    message: json["message"],
    authToken: json["auth_token"],
    refreshToken: json["refresh_token"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_successful": isSuccessful,
    "message": message,
    "auth_token": authToken,
    "refresh_token": refreshToken,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };



}