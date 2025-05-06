import 'package:Cooply/models/dtos/AccountResponse.dart';

class Farm {
  final int id;
  final String name;
  final String author;
  final bool? status;
  final AccountResponse account;

  Farm({
    required this.id,
    required this.name,
    required this.author,
    this.status,
    required this.account,
  });

  factory Farm.fromJson(Map<String, Object?> json) {
    return Farm(
      id: json['id'] as int,
      name: json['name'] as String,
      author: json['author'] as String,
      status: json['status'] as bool,
      account:   AccountResponse.fromJson(json['account'] as Map<String,Object?>)
    );
  }
}

class PaginatedFarmsResponse{
  final List<Farm> content;
  final int totalElements;
  final int pageNumber;
  final int pageSize;

  PaginatedFarmsResponse({
    required this.content,
    required this.totalElements,
    required this.pageNumber,
    required this.pageSize,
  });


  factory PaginatedFarmsResponse.fromJson(Map<String, dynamic> json) {
    final List contentJson = json['content'];
    return PaginatedFarmsResponse(
      content: contentJson.map((e) => Farm.fromJson(e)).toList(),
      totalElements: json['totalElements'],
      pageNumber: json['number'],
      pageSize: json['size'],
    );
  }

}
