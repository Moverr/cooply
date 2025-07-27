class ErrorResponse {
  String timestamp;
  String code;
  String status;
  String message;

  ErrorResponse({
    required this.timestamp,
    required this.code,
    required this.status,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, Object?> json) => ErrorResponse(
        timestamp: json["timestamp"] as String,
        code: json["code"] as String,
        status: json["status"] as String,
        message: json["message"] as String,
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "code": code,
        "status": status,
        "message": message,
      };
}
