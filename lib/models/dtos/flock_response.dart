class FlockResponse {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ActedBy? createdBy;
  final ActedBy? updatedBy;
  final int? id;
  final String? batchNo;
  final String? referenceNo;
  final String? externalId;
  final int? birdsAcquired;
  final String? flockType;
  final dynamic flockBreed;
  final DateTime? dateAcquired;
  final String? acquisitionType;
  final dynamic notes;
  // final List<dynamic>? payments;
  // final dynamic suppliers;
  final String? author;
  final dynamic inventorySummary;
  final dynamic feedSummary;
  final dynamic healthSummary;
  final dynamic waterSummary;
  // final Coop? coop;

  FlockResponse({
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.id,
    this.batchNo,
    this.referenceNo,
    this.externalId,
    this.birdsAcquired,
    this.flockType,
    this.flockBreed,
    this.dateAcquired,
    this.acquisitionType,
    this.notes,
    // this.payments,
    // this.suppliers,
    this.author,
    this.inventorySummary,
    this.feedSummary,
    this.healthSummary,
    this.waterSummary,
    // this.coop,
  });

  factory FlockResponse.fromJson(Map<String, dynamic> json) {
    DateTime? _tryParseDate(String? date) {
      if (date == null || date.isEmpty) return null;
      try {
        return DateTime.parse(date);
      } catch (_) {
        return null;
      }
    }

    return FlockResponse(
      createdAt: _tryParseDate(json["created_at"]),
      updatedAt: _tryParseDate(json["updated_at"]),
      createdBy: json["created_by"] != null ? ActedBy.fromJson(json["created_by"]) : null,
      updatedBy: json["updated_by"] != null ? ActedBy.fromJson(json["updated_by"]) : null,
      id: json["id"],
      batchNo: json["batch_no"],
      referenceNo: json["reference_no"],
      externalId: json["external_id"],
      birdsAcquired: json["birds_acquired"],
      flockType: json["flock_type"],
      flockBreed: json["flock_breed"],
      dateAcquired: _tryParseDate(json["date_acquired"]),
      acquisitionType: json["acquisition_type"],
      notes: json["notes"],
      // payments: (json["payments"] as List?)?.map((x) => x).toList(),
      // suppliers: json["suppliers"],
      author: json["author"],
      inventorySummary: json["inventory_summary"],
      feedSummary: json["feed_summary"],
      healthSummary: json["health_summary"],
      waterSummary: json["water_summary"],
      // coop: json["coop"] != null ? Coop.fromJson(json["coop"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "created_by": createdBy?.toJson(),
    "updated_by": updatedBy?.toJson(),
    "id": id,
    "batch_no": batchNo,
    "reference_no": referenceNo,
    "external_id": externalId,
    "birds_acquired": birdsAcquired,
    "flock_type": flockType,
    "flock_breed": flockBreed,
    "date_acquired": dateAcquired?.toIso8601String(),
    "acquisition_type": acquisitionType,
    "notes": notes,
    // "payments": payments,
    // "suppliers": suppliers,
    "author": author,
    "inventory_summary": inventorySummary,
    "feed_summary": feedSummary,
    "health_summary": healthSummary,
    "water_summary": waterSummary,
    // "coop": coop?.toJson(),
  };
}

class ActedBy {
  final String? name;
  final int? id;

  ActedBy({this.name, this.id});

  factory ActedBy.fromJson(Map<String, dynamic> json) => ActedBy(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
