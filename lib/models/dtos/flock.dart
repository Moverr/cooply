import 'dart:convert';

import 'package:Cooply/models/dtos/Farm.dart';
import 'package:flutter/cupertino.dart';

class Flock {
  final int id;
  final String batchName;
  final String author;
  final String? status;
  final String? coopName;
  final String? acquiredOn;
  final String? createdOn;
  final String? modifiedOn;
  final double? currentBirdCount;
  final String? type;
  final double? mortality;
  final double? stock;
  final String? stage;

  Flock(
      {required this.id,
        required this.batchName,
        required this.author,
        required this.status,
        required this.coopName,
        required this.createdOn,
        required this.modifiedOn,
        required this.currentBirdCount,
        required this.type,
        required this.acquiredOn,
        required this.mortality,
        required this.stage,
        required this.stock,

      });

  factory Flock.fromJson(Map<String, Object?> json) {
    return Flock(
      id: json['id'] as int,
      batchName: json['name'] as String,
      author: json['author'] as String,
      status: json['status'] as String?,
      coopName: json['farm_name'] as String?,
      createdOn: json['created_on'] as String?,
      modifiedOn: json['modified_on'] as String?,
      acquiredOn: json['acquired_on'] as String?,
      currentBirdCount: 0 as double?,
      type: json['type'] as String?,
      stage: json['stage'] as String?,
      mortality: json['motality'] as double?,
      stock: json['stock'] as double?,
    );
  }
}

class PaginatedFlockResponse {
  final List<Flock> content;
  final int totalElements;
  final int pageNumber;
  final int pageSize;

  PaginatedFlockResponse({
    required this.content,
    required this.totalElements,
    required this.pageNumber,
    required this.pageSize,
  });

  factory PaginatedFlockResponse.fromJson(Map<String, dynamic> json) {
    debugPrint(">>>>>>>>>>>>>>>>>>>");
    debugPrint(jsonEncode(json));
    debugPrint(">>>>>>>>>>>>>>>>>>>");

    final List contentJson = json['content'];
    return PaginatedFlockResponse(
      content: contentJson.map((e) => Flock.fromJson(e)).toList(),
      totalElements: json['totalElements'],
      pageNumber: json['number'],
      pageSize: json['size'],
    );
  }
}
