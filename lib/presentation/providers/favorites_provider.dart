import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/favorites_entity.dart';
import 'package:yumzi/data/models/entity/menu_item_entity.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/data/services/favorites_service.dart';

class FavoritesProvider extends ChangeNotifier {
  FavoritesService service = FavoritesService();

  bool _isLoading = false;
  String? _errorMessage;
  List<RestaurantEntity> _favoriteRestaurants = [];
  List<MenuItemEntity> _favoriteMenuItems = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<RestaurantEntity> get favoriteRestaurants => _favoriteRestaurants;
  List<MenuItemEntity> get favoriteMenuItems => _favoriteMenuItems;

  Future<FavoritesEntity> fetchFavorites() async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final rootEntity = await service.fetchFavorites();

      if (rootEntity.status == 200) {
        final FavoritesEntity favoritesJson = FavoritesEntity.fromJson(
          rootEntity.payload,
        );
        _favoriteRestaurants = favoritesJson.favoriteRestaurants;
        _favoriteMenuItems = favoritesJson.favoriteItems;
        _isLoading = false;
        return favoritesJson;
      } else {
        _errorMessage = 'Failed to load favorites.';
        return FavoritesEntity(favoriteItems: [], favoriteRestaurants: []);
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      return FavoritesEntity(favoriteItems: [], favoriteRestaurants: []);
    }
  }

  Future<bool?> toggleFavoriteRestaurant(
    String restaurantId,
    bool isFavorite,
  ) async {
    try {
      if (!isFavorite) {
        await service.removeFavoriteRestaurant(restaurantId);
        _favoriteRestaurants.removeWhere((r) => r.uniqueId == restaurantId);
        notifyListeners();
        return false;
      } else {
        await service.addFavoriteRestaurant(restaurantId);
        notifyListeners();
        return true;
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool?> toggleFavoriteMenuItem(
    String menuItemId,
    bool isFavorite,
  ) async {
    try {
      if (!isFavorite) {
        await service.removeFavoriteMenuItem(menuItemId);
        _favoriteMenuItems.removeWhere((m) => m.uniqueId == menuItemId);
        notifyListeners();
        return false;
      } else {
        await service.addFavoriteMenuItem(menuItemId);
        notifyListeners();
        return true;
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }
}
