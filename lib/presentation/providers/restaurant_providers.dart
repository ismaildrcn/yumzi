import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/data/services/restaurant_service.dart';

class RestaurantProviders extends ChangeNotifier {
  final RestaurantService _service = RestaurantService();

  bool _isLoading = false;
  String? _errorMessage;
  List<RestaurantEntity>? _restaurants;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<RestaurantEntity>? get restaurants => _restaurants;

  Future<List<RestaurantEntity>?> fetchRestaurants() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rootEntity = await _service.fetchRestaurants();
      _isLoading = false;
      notifyListeners();

      if (rootEntity.status == 200) {
        _restaurants = (rootEntity.payload as List)
            .map((json) => RestaurantEntity.fromJson(json))
            .toList();
        notifyListeners();
        return _restaurants;
      } else {
        _errorMessage = 'Failed to load restaurants';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An error occurred while fetching restaurants';
      notifyListeners();
      return null;
    }
  }
}
