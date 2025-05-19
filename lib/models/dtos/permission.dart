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

  factory Permission.fromJson(Map<String, Object?> json) => Permission(
    resourceName: json['resource_name'] as String,
    create: json['create'] as String,
    view: json['view'] as String,
    edit: json['edit'] as String,
    archive: json['archive']as String,
    delete: json['delete']as String,
    restore: json['restore']as String,
    isSystem: json['is_system'] as bool,
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