import 'dart:convert';

import 'package:Cooply/models/dtos/Farm.dart';
import 'package:flutter/cupertino.dart';

class Coop {
  final int id;
  final String name;
  final String reference;
  final String author;
  final String? status;
  final String? farmName;
  final String? createdOn;
  final String? modifiedOn;
  final double? currentFlock;
  final double? acquiredFlock;
  final String? type;
  final double? capacity;

  Coop(
      {
      required this.id,
      required this.name,
      required this.reference,
      required this.author,
      required this.status,
      required this.farmName,
      required this.createdOn,
      required this.modifiedOn,
      required this.currentFlock,
        required this.acquiredFlock,
      required this.type,
        required this.capacity
      });

  factory Coop.fromJson(Map<String, Object?> json) {
    return Coop(
      id: json['id'] as int,
      name: json['name'] as String,
      reference: json['reference'] as String,
      author: json['author'] as String,
      status: json['status'] as String?,
      farmName: json['farm_name'] as String?,
      createdOn: json['created_on'] as String?,
      modifiedOn: json['modified_on'] as String?,

      type: json['type'] as String?,

      //flock inventory
      currentFlock:  json['current_flock'] as double?,
      acquiredFlock:  json['acquired_flock'] as double?,
      capacity: json['capacity'] as double?,
    );
  }
}

class PaginatedCoopResponse {
  final List<Coop> content;
  final int totalElements;
  final int pageNumber;
  final int pageSize;

  PaginatedCoopResponse({
    required this.content,
    required this.totalElements,
    required this.pageNumber,
    required this.pageSize,
  });

  factory PaginatedCoopResponse.fromJson(Map<String, dynamic> json) {
    debugPrint(">>>>>>>>>>>>>>>>>>>");
    debugPrint(jsonEncode(json));
    debugPrint(">>>>>>>>>>>>>>>>>>>");

    final List contentJson = json['content'];
    return PaginatedCoopResponse(
      content: contentJson.map((e) => Coop.fromJson(e)).toList(),
      totalElements: json['totalElements'],
      pageNumber: json['number'],
      pageSize: json['size'],
    );
  }
}
