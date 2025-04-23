class AccountResponse{

  int id;
  String name;
  String author;
  String referenceId;

  AccountResponse({
    required this.id,
    required this.name,
    required this.author,
    required this.referenceId,
  });



  factory AccountResponse.fromJson(Map<String, Object?> json) => AccountResponse(
    id: json["id"] as int,
    name: json["name"] as String,
    author: json["author"] as  String,
    referenceId: json["reference_id"] as String,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "author": author,
    "reference_id": referenceId,
  };


}