import 'package:yumzi/data/models/enums/user_gender.dart';

class DtoUserResponse {
  String uniqueId;
  String email;
  String? phoneNumber;
  String? fullName;
  UserGender? gender;
  DateTime? birthOfDate;
  bool emailVerified;
  bool phoneNumberVerified;
  String role;

  DtoUserResponse({
    required this.uniqueId,
    required this.email,
    this.phoneNumber,
    this.fullName,
    this.gender,
    this.birthOfDate,
    required this.emailVerified,
    required this.phoneNumberVerified,
    required this.role,
  });

  factory DtoUserResponse.fromJson(Map<String, dynamic> json) {
    return DtoUserResponse(
      uniqueId: json['uniqueId'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      fullName: json['fullName'],
      gender: json['gender'] != null
          ? UserGender.values.firstWhere((e) => e.value == json['gender'])
          : null,
      birthOfDate: json['birthOfDate'] != null
          ? DateTime.parse(json['birthOfDate'])
          : null,
      emailVerified: json['emailVerified'],
      phoneNumberVerified: json['phoneNumberVerified'],
      role: json['role'],
    );
  }
}
