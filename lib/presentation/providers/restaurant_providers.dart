import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/menu_item_entity.dart';
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

  Future<RestaurantEntity?> fetchRestaurantDetails(String restaurantId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rootEntity = await _service.fetchRestaurantDetails(restaurantId);
      _isLoading = false;
      notifyListeners();

      if (rootEntity.status == 200) {
        return RestaurantEntity.fromJson(rootEntity.payload!);
      } else {
        _errorMessage = 'Failed to load restaurant details';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An error occurred while fetching restaurant details';
      notifyListeners();
      return null;
    }
  }

  Future<List<RestaurantEntity>?> fetchRestaurantsByCategory(
    String categoryId,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rootEntity = await _service.fetchRestaurantsByCategory(categoryId);
      _isLoading = false;
      notifyListeners();

      if (rootEntity.status == 200) {
        return (rootEntity.payload as List)
            .map((json) => RestaurantEntity.fromJson(json))
            .toList();
      } else {
        _errorMessage = 'Failed to load restaurants for category';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage =
          'An error occurred while fetching restaurants for category';
      notifyListeners();
      return null;
    }
  }

  // Menu Item Fetching Methods
  Future<List<MenuItemEntity>?> fetchMenuItemsWithCategory(String restaurantId, String categoryId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rootEntity = await _service.fetchMenuItems(restaurantId, categoryId);
      _isLoading = false;
      notifyListeners();

      if (rootEntity.status == 200) {
        return (rootEntity.payload as List)
            .map((json) => MenuItemEntity.fromJson(json))
            .toList();
      } else {
        _errorMessage = 'Failed to load menu items';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An error occurred while fetching menu items';
      notifyListeners();
      return null;
    }
  }
}
