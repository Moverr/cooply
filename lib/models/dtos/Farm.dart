import 'package:Cooply/models/dtos/AccountResponse.dart';

class FarmData {
  final int id;
  final String name;
  final String author;
  final bool? status;
  final AccountResponse account;

  FarmData({
    required this.id,
    required this.name,
    required this.author,
    this.status,
    required this.account,
  });

  factory FarmData.fromJson(Map<String, Object?> json) {
    return FarmData(
      id: json['id'] as int,
      name: json['name'] as String,
      author: json['author'] as String,
      status: json['status'] as bool,
      account:   AccountResponse.fromJson(json['account'] as Map<String,Object?>)
    );
  }
}
