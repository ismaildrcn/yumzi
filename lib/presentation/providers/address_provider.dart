import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/address_entity.dart';
import 'package:yumzi/data/services/address_service.dart';

class AddressProvider extends ChangeNotifier {
  final AddressService _addressService = AddressService();

  bool _isLoading = false;
  String? _errorMessage;
  List<AddressEntity> _addresses = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<AddressEntity> get addresses => _addresses;

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
}
