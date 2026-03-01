import 'package:dio/dio.dart';
import 'package:yumzi/core/network/dio_client.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';
import 'package:yumzi/data/models/entity/address_entity.dart';

class AddressService {
  final Dio _dio = DioClient().dio;
  final String urlPrefix = '/rest/api';

  Future<RootEntity> fetchAddresses() async {
    final response = await _dio.get('$urlPrefix/address/list');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Adresler alınamadı');
    }
  }

  Future<RootEntity> saveAddress(AddressEntity address) async {
    final response = await _dio.post(
      '$urlPrefix/address/save',
      data: address.toJson(),
    );
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Adres kaydedilemedi');
    }
  }

  Future<RootEntity> updateAddress(AddressEntity address) async {
    final response = await _dio.patch(
      '$urlPrefix/address/update/${address.uniqueId}',
      data: address.toJson(),
    );
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Adres güncellenemedi');
    }
  }

  Future<RootEntity> deleteAddress(String uniqueId) async {
    final response = await _dio.delete('$urlPrefix/address/delete/$uniqueId');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Adres silinemedi');
    }
  }

  Future<RootEntity> fetchDefaultAddress() async {
    final response = await _dio.get('$urlPrefix/address/default');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('Varsayılan adres alınamadı');
    }
  }

  Future<RootEntity> fetchProvinces() async {
    final response = await _dio.get('$urlPrefix/addresses/provinces');
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('İller alınamadı');
    }
  }

  Future<RootEntity> fetchDistricts(String provinceName) async {
    final response = await _dio.get(
      '$urlPrefix/addresses/districts/$provinceName',
    );
    if (response.data["status"] == 200) {
      return RootEntity.fromJson(response.data);
    } else {
      throw Exception('İlçeler alınamadı');
    }
  }
}
