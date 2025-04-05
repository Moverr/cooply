import 'Permission.dart';

class Role{
  int id;
  String name;
  List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.permissions,
  });


  factory Role.fromJson(Map<String, Object?> json) => Role(
    id: json['id'] as int,
    name: json['name'] as String,
    permissions: (json['permissions'] as List)
        .map((x) => Permission.fromJson(x as Map<String, Object?>))
        .toList(),
    // permissions: List<Permission>.from(
    //   json['permissions'].map((x) => Permission.fromJson(x)),
    // ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
  };


}