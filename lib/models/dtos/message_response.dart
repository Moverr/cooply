


class MessageResponse{
  String message;
  String status;

  MessageResponse({
    required this.message,
    required this.status,
  });



  factory MessageResponse.fromJson(Map<String, Object?> json) => MessageResponse(
    message: json["message"] as String,
    status: json["status"] as String,
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };



}