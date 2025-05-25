import 'dart:convert';

import 'package:Cooply/models/dtos/Farm.dart';
import 'package:flutter/cupertino.dart';

class FeedInventoryLog {
  final int id;
  final String itemName;
  final double? quantity;
  final double? availableQuantity;
  final String? transactionType; // ADD, DELETE

  FeedInventoryLog({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.availableQuantity,
    required this.transactionType,
  });

  factory FeedInventoryLog.fromJson(Map<String, Object?> json) {
    return FeedInventoryLog(
      id: json['id'] as int,
      itemName: json['item_name'] as String,
      quantity: json['quantity'] as double,
      availableQuantity: json['available_quantity'] as double,
      transactionType: json['amount_type'] as String?,
    );
  }
}

class FeedInventory {
  final int id;
  final String batchId;
  final double? quantity;
  final double? availableQuantity;
  final String? transactionType; //todo: create an enum [Addition,reduction]
  final String? farm;
  final String? flock;
  final String author;
  final String? registeredDate;
  final String? createdOn;
  final String? modifiedOn;

  List<FeedInventoryLog> items;

  FeedInventory(
      {required this.id,
      required this.batchId,
      required this.quantity,
      required this.availableQuantity,
      required this.transactionType, //todo: create an enum
      required this.farm,
      required this.flock,
      required this.author,
      required this.registeredDate,
      required this.createdOn,
      required this.modifiedOn,
      required this.items});

  factory FeedInventory.fromJson(Map<String, Object?> json) {
    return FeedInventory(
      id: json['id'] as int,
      batchId: json['batch_id'] as String,
      quantity: json['quantity'] as double,
      availableQuantity: json['available_quantity'] as double,
      transactionType: json['amount_type'] as String?,
      farm: json['farm'] as String?,
      flock: json['flock'] as String?,
      author: json['author'] as String,
      registeredDate: json['registered_date'] as String?,
      createdOn: json['created_on'] as String,
      modifiedOn: json['modified_on'] as String,
      items: (json['inventory_log'] as List)
          .map((x) => FeedInventoryLog.fromJson(x as Map<String, Object?>))
          .toList(),
    );
  }
}

class PaginatedFeedInventoryResponse {
  final List<FeedInventory> content;
  final int totalElements;
  final int pageNumber;
  final int pageSize;

  PaginatedFeedInventoryResponse({
    required this.content,
    required this.totalElements,
    required this.pageNumber,
    required this.pageSize,
  });

  factory PaginatedFeedInventoryResponse.fromJson(Map<String, dynamic> json) {
    debugPrint(">>>>>>>>>>>>>>>>>>>");
    debugPrint(jsonEncode(json));
    debugPrint(">>>>>>>>>>>>>>>>>>>");

    final List contentJson = json['content'];
    return PaginatedFeedInventoryResponse(
      content: contentJson.map((e) => FeedInventory.fromJson(e)).toList(),
      totalElements: json['totalElements'],
      pageNumber: json['number'],
      pageSize: json['size'],
    );
  }
}
