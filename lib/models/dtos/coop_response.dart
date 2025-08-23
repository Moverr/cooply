


import 'dart:core';

import 'package:Cooply/models/dtos/Farm.dart';
import 'package:Cooply/models/dtos/author_response.dart';
import 'package:Cooply/models/dtos/power_response.dart';
import 'package:Cooply/models/dtos/water_response.dart';

import 'employee_response.dart';

class CoopResponse {
  final String name;
  final String? referenceId;
 final AuthorResponse? author;
 final Farm? farm;
  final String? area;
  final List<PowerResponse>? power;
  final List<WaterResponse>? water;
  final List<String?>? breed;
  final List<String?>? stage;
  final EmployeeResponse? employee; // made nullable
  final double? capacity;
  final double? occupied;


  CoopResponse({
    required this.name,
    this.referenceId,
     this.author,
    this.farm,
    this.area,
    required this.power,
    required this.water,
    required this.breed,
    required this.stage,
    this.employee, // nullable
    this.capacity,
    this.occupied,

  });

  factory CoopResponse.fromJson(Map<String, dynamic> json) {
    return CoopResponse(
      name: json['name'] as String? ?? '',
      referenceId: json['reference_id'] as String?,
      author: json['author'] != null
          ? AuthorResponse.fromJson(json['author'] as Map<String, dynamic>)
          : null,

      farm: json['farm'] != null
          ? Farm.fromJson(json['farm'] as Map<String, dynamic>)
          : null,
      area: json['area'] as String?,
      power: (json['power'] as List<dynamic>?)
          ?.map((x) => PowerResponse.fromJson(x as Map<String, dynamic>))
          .toList(),
      water: (json['water'] as List<dynamic>?)
          ?.map((x) => WaterResponse.fromJson(x as Map<String, dynamic>))
          .toList(),
      breed: (json['breed'] as List<dynamic>?)?.map((x) => x as String?).toList(),
      stage: (json['stage'] as List<dynamic>?)?.map((x) => x as String?).toList(),
      employee: json['employee'] != null
          ? EmployeeResponse.fromJson(json['employee'] as Map<String, dynamic>)
          : null,
      capacity: (json['capacity'] ?? json['cpaacity']) != null
          ? (json['capacity'] ?? json['cpaacity']).toDouble()
          : null,
      occupied: (json['occupied'] as num?)?.toDouble(),
    );
  }


}
