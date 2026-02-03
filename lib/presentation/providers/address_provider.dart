import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/address_entity.dart';
import 'package:yumzi/data/models/entity/district_entity.dart';
import 'package:yumzi/data/models/entity/province_entity.dart';
import 'package:yumzi/data/services/address_service.dart';

class AddressProvider extends ChangeNotifier {
  final AddressService _addressService = AddressService();

  bool _isLoading = false;
  String? _errorMessage;
  List<AddressEntity> _addresses = [];
  List<ProvinceEntity> _provinces = [];
  List<DistrictEntity> _districts = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<AddressEntity> get addresses => _addresses;

  List<String?> get provinces =>
      _provinces.map((province) => province.name).toList();

  List<String?> get districts =>
      _districts.map((district) => district.name).toList();

  Future<List<AddressEntity>?> fetchAddresses() async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final rootEntity = await _addressService.fetchAddresses();

      if (rootEntity.status == 200) {
        final List<dynamic> addressListJson =
            rootEntity.payload as List<dynamic>;
        _addresses = addressListJson
            .map((addressJson) => AddressEntity.fromJson(addressJson))
            .toList();
        _isLoading = false;
        return _addresses;
      } else {
        _errorMessage = 'Failed to load addresses.';
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      return null;
    }
  }

  Future<int> saveAddress(AddressEntity address) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rootEntity = await _addressService.saveAddress(address);
      if (rootEntity.status == 200) {
        _addresses.add(address);
        return rootEntity.status;
      } else {
        _errorMessage = 'Failed to save address.';
        return rootEntity.status;
      }
    } catch (e) {
      _errorMessage = 'Failed to save address.';
      return -1;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> deleteAddress(String uniqueId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rootEntity = await _addressService.deleteAddress(uniqueId);
      if (rootEntity.status == 200) {
        _addresses.removeWhere((address) => address.uniqueId == uniqueId);
        return rootEntity.status;
      } else {
        _errorMessage = 'Failed to delete address.';
        return rootEntity.status;
      }
    } catch (e) {
      _errorMessage = 'Failed to delete address.';
      return -1;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<int> fetchProvinces() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final rootEntity = await _addressService.fetchProvinces();

      if (rootEntity.status == 200) {
        final List<dynamic> provinceListJson =
            rootEntity.payload as List<dynamic>;
        _provinces = provinceListJson
            .map((provinceJson) => ProvinceEntity.fromJson(provinceJson))
            .toList();
        return rootEntity.status;
      } else {
        _errorMessage = 'Failed to load provinces.';
        return rootEntity.status;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return -1;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> fetchDistricts(String provinceName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final rootEntity = await _addressService.fetchDistricts(provinceName);

      if (rootEntity.status == 200) {
        final List<dynamic> districtListJson =
            rootEntity.payload as List<dynamic>;
        _districts = districtListJson
            .map((districtJson) => DistrictEntity.fromJson(districtJson))
            .toList();
        return rootEntity.status;
      } else {
        _errorMessage = 'Failed to load districts.';
        return rootEntity.status;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return -1;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
