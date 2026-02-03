import 'package:yumzi/data/models/enums/address_type.dart';

class AddressEntity {
  String? uniqueId;
  String title;
  AddressType addressType;
  String addressLine1;
  String? addressLine2;
  String neighborhood;
  String district;
  String province;
  String country;
  String recipientName;
  String phoneNumber;
  String latitude;
  String longitude;
  bool isDefault;

  AddressEntity({
    this.uniqueId,
    required this.title,
    required this.addressType,
    required this.addressLine1,
    this.addressLine2,
    required this.neighborhood,
    required this.district,
    required this.province,
    required this.country,
    required this.recipientName,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });

  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    return AddressEntity(
      uniqueId: json['uniqueId'],
      title: json['title'],
      addressType: AddressType.values.firstWhere(
        (e) => e.value == json['addressType'],
      ),
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      neighborhood: json['neighborhood'],
      district: json['district'],
      province: json['province'],
      country: json['country'],
      recipientName: json['recipientName'],
      phoneNumber: json['phoneNumber'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isDefault: json['isDefault'] ?? json['default'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'addressType': addressType.value,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'neighborhood': neighborhood,
      'district': district,
      'province': province,
      'country': country,
      'recipientName': recipientName,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'isDefault': isDefault,
    };
  }
}
