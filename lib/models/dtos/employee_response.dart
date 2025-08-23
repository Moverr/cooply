class EmployeeResponse {
  String? manager;
  int employees;

  EmployeeResponse({this.manager, required this.employees});

  factory EmployeeResponse.fromJson(Map<String, Object?> json) {
    return EmployeeResponse(
        manager: json['manager'] as String?,
        employees: json['employees'] as int);
  }


}
