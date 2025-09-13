class WaterResponse {
  String? source;
  String? status;

  WaterResponse({this.source, this.status});

  factory WaterResponse.fromJson(Map<String, Object?> json) {
    return WaterResponse(
        source: json['source'] as String?,
        status: json['status'] as String?);
  }


}
