import 'package:yumzi/data/models/enums/user_gender.dart';

class UserEntity {
  String uniqueId;
  String email;
  String? phoneNumber;
  String fullName;
  UserGender? gender;
  DateTime? birthOfDate;
  bool emailVerified;
  bool phoneNumberVerified;

  UserEntity({
    required this.uniqueId,
    required this.email,
    this.phoneNumber,
    required this.fullName,
    this.gender,
    this.birthOfDate,
    required this.emailVerified,
    required this.phoneNumberVerified,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uniqueId': uniqueId,
      'email': email,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'gender': gender?.value,
      'birthOfDate': birthOfDate?.toIso8601String(),
      'emailVerified': emailVerified,
      'phoneNumberVerified': phoneNumberVerified,
    };
  }
}
