import 'package:yumzi/data/models/enums/user_gender.dart';

class UserModel {
  String uniqueId;
  String email;
  String? phoneNumber;
  String fullName;
  UserGender? gender;
  DateTime? birthOfDate;
  bool emailVerified;
  bool phoneNumberVerified;
  String role;

  UserModel({
    required this.uniqueId,
    required this.email,
    this.phoneNumber,
    required this.fullName,
    this.gender,
    this.birthOfDate,
    required this.emailVerified,
    required this.phoneNumberVerified,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
