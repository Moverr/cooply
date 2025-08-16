import 'dart:convert';

import 'package:Cooply/models/dtos/accountResponse.dart';
import 'package:flutter/cupertino.dart';

import 'address.dart';

class Farm {
  final int id;
  final String name;
  String? author;
  String? status;
  AccountResponse? account;
  String? createdOn;
  String? modifiedOn;
  double? coops;
  double? flock;
  bool isDefault;

  List<Address> addresses;
  String? details;

  /*
  @JsonProperty("addresses")
  private List<AddressResponse> addresses;


  @JsonProperty("is_default")
  private boolean isDefault;

  @JsonProperty("details")
  private String details;
  */

  Farm({
    required this.id,
    required this.name,
    this.author,
    this.status,
    this.account,
    this.createdOn,
    this.modifiedOn,
    this.coops,
    this.flock,
    required this.isDefault,
     this.details,
    this.addresses = const [],
  });

  factory Farm.fromJson(Map<String, Object?> json) {
    return Farm(
      id: json['id'] as int,
      name: json['name']  as String,
      author: json['author'] as String?, // safely nullable
      status: json['status'] as String?,
      account: json['account'] != null
          ? AccountResponse.fromJson(json['account'] as Map<String, Object?>)
          : null,
      createdOn: json['created_on'] as String?,
      modifiedOn: json['modified_on'] as String?,
      coops: (json['coops'] != null)
          ? (json['coops'] is int
              ? (json['coops'] as int).toDouble()
              : json['coops'] as double)
          : null,
      flock: (json['flock'] != null)
          ? (json['flock'] is int
              ? (json['flock'] as int).toDouble()
              : json['flock'] as double)
          : null,

      isDefault: json['is_default'] as bool,
      details: json['details'] as String?,
      addresses: (json['addresses'] as List)
          .map((x) => Address.fromJson(x as Map<String, Object?>))
          .toList(),
    );
  }
}

class PaginatedFarmsResponse {
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
    debugPrint(">>>>>>>>>>>>>>>>>>>");
    debugPrint(jsonEncode(json));
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
