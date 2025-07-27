import 'package:Cooply/models/dtos/accountResponse.dart';

import 'role.dart';

class LoginResponse{

  String username;
  String status;
  String message;
  String auth_token;
  String refresh_token;
  List<Role> roles;

  AccountResponse defaultAccount;
  List<AccountResponse> accounts;

  LoginResponse({
    required this.username,
    required this.status,
    required this.message,
    required this.auth_token,
    required this.refresh_token,
    required this.roles,
    required this.defaultAccount,
    required this.accounts,
  });







  factory LoginResponse.fromJson(Map<String, Object?> json) => LoginResponse(
    username: json["username"] as String,
    status: json["status"] as String,
    message: json["message"] as String,
    auth_token: json["auth_token"] as String,
    refresh_token: json["refresh_token"] as String,
    roles: (json['roles'] as List).map((x) => Role.fromJson(x as Map<String, Object?>)).toList(),
    defaultAccount: AccountResponse.fromJson(json["defaultAccount"] as Map<String, Object?>),
    accounts: (json['accounts'] as List).map((x) => AccountResponse.fromJson(x as Map<String, Object?>)).toList(),


    // roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "auth_token": auth_token,
    "refresh_token": refresh_token,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };



}