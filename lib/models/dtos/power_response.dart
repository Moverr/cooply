class PowerResponse {
  String? powerType;
  String? status;

  PowerResponse({this.powerType, this.status});

  factory PowerResponse.fromJson(Map<String, Object?> json) {
    return PowerResponse(
        powerType: json['power_type'] as String?,
        status: json['status'] as String?);
  }


}
