class DtoLoginRequest {
  final String email;
  final String password;

  DtoLoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
