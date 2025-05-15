import 'dart:convert';

import 'package:Cooply/models/dtos/AccountResponse.dart';
import 'package:flutter/cupertino.dart';

class Farm {
  final int id;
  final String name;
  final String author;
  final String ? status;
   final AccountResponse account;
  final String ? createdOn;
  final String ? modifiedOn;


  Farm({
    required this.id,
    required this.name,
    required this.author,
    required this.status,
    required this.account,
    required this.createdOn,
    required this.modifiedOn,
  });

  factory Farm.fromJson(Map<String, Object?> json) {
    return Farm(
      id: json['id'] as int,
      name: json['name'] as String,
      author: json['author'] as String,
      status: json['status'] as String?,
      account:   AccountResponse.fromJson(json['account'] as Map<String,Object?>),
      createdOn: json['created_on'] as String?,
      modifiedOn: json['modified_on'] as String?,
    );
  }
}

class PaginatedFarmsResponse{
  final List<Farm> content;
  final int totalElements;
  final int pageNumber;
  final int pageSize;

  PaginatedFarmsResponse(
  {
    required this.content,
    required this.totalElements,
    required this.pageNumber,
    required this.pageSize,
  }
  );



  factory PaginatedFarmsResponse.fromJson(Map<String, dynamic> json) {

    debugPrint(">>>>>>>>>>>>>>>>>>>");
    debugPrint(jsonEncode(json ));
    debugPrint(">>>>>>>>>>>>>>>>>>>");

     final List contentJson = json['content'];
    return PaginatedFarmsResponse(
       content: contentJson.map((e) => Farm.fromJson(e)).toList(),
      totalElements: json['totalElements'],
      pageNumber: json['number'],
      pageSize: json['size'],
    );
  }

}
