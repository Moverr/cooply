class WaterResponse {
  String? waterType;
  String? status;

  WaterResponse({this.waterType, this.status});

  factory WaterResponse.fromJson(Map<String, Object?> json) {
    return WaterResponse(
        waterType: json['water_type'] as String?,
        status: json['status'] as String?);
  }


}
