class Permission{

  String resourceName;
  String create;
  String view;
  String edit;
  String archive;
  String delete;
  String restore;
  bool isSystem;


  Permission({
    required this.resourceName,
    required this.create,
    required this.view,
    required this.edit,
    required this.archive,
    required this.delete,
    required this.restore,
    required this.isSystem,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    resourceName: json["resource_name"],
    create: json["create"],
    view: json["view"],
    edit: json["edit"],
    archive: json["archive"],
    delete: json["delete"],
    restore: json["restore"],
    isSystem: json["is_system"],
  );

  Map<String, dynamic> toJson() => {
    "resource_name": resourceName,
    "create": create,
    "view": view,
    "edit": edit,
    "archive": archive,
    "delete": delete,
    "restore": restore,
    "is_system": isSystem,
  };
}