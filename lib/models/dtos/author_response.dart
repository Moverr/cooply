
class AuthorResponse{


  final String? email;
  final String? firstname;
  final String? lastname;

  AuthorResponse({ required this.email,required this.firstname, required this.lastname});


  factory AuthorResponse.fromJson(Map<String, Object?> json) {
    return AuthorResponse(
      email: json['email'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastName'] as String?,

    );
  }

  
}