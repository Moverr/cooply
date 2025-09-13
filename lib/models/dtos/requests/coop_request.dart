import 'dart:convert';

/// CoopRequest model for sending coop creation request to backend.
/// Author: Muyinda Rogers
/// Date: 2025-01-07

class CoopRequest {
  final int farmId;
  final String name;
   final String area; // area in m2 (string as in Java)
  final double capacity; // computed or provided
  final String type; // Coop type (enum in backend)
  final List<PowerRequest> power;
  final List<WaterRequest> water;

  CoopRequest({
    required this.farmId,
    required this.name,
    required this.area,
    required this.capacity,
    required this.type,
    required this.power,
    required this.water,
  });

  Map<String, dynamic> toJson() {
    return {
      "farm_id": farmId,
      "name": name,
      "area": area,
      "cpaacity": capacity,
      "type": type,
      "power": power.map((p) => p.toJson()).toList(),
      "water": water.map((w) => w.toJson()).toList(),
    };
  }

  String toRawJson() => jsonEncode(toJson());
}

/// Example sub-request classes
class PowerRequest {
  final String name;
  final String status;

  PowerRequest({required this.name, required this.status});

  Map<String, dynamic> toJson() => {
    "name": name,
    "status": status,
  };
}

class WaterRequest {
  final String source;
  final String status;

  WaterRequest({required this.source, required this.status});

  Map<String, dynamic> toJson() => {
    "source": source,
    "status": status,
  };
}
