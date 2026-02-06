import 'package:flutter/material.dart';
import 'package:yumzi/data/models/dto/root_entity.dart';
import 'package:yumzi/data/models/entity/restaurant_category_entity.dart';
import 'package:yumzi/data/services/restaurant_category_service.dart';

class RestaurantCategoryProvider extends ChangeNotifier {
  final RestaurantCategoryService _service = RestaurantCategoryService();
  bool _isLoading = false;
  String? _errorMessage;
  List<RestaurantCategoryEntity> _categories = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<RestaurantCategoryEntity> get categories => _categories;

  Future<List<RestaurantCategoryEntity>?> getCategories() async {
    _isLoading = true;
    _errorMessage = null;
    try {
      RootEntity rootEntity = await _service.fetchCategories();
      if (rootEntity.payload != null && rootEntity.payload is List) {
        List<RestaurantCategoryEntity> categories = (rootEntity.payload as List)
            .map((item) => RestaurantCategoryEntity.fromJson(item))
            .toList();
        _categories = categories;
        _isLoading = false;
        return categories;
      } else {
        _errorMessage =
            'Restoran kategorileri alınamadı: Geçersiz veri formatı';
        _isLoading = false;
        return null;
      }
    } catch (e) {
      _errorMessage = 'Restoran kategorileri alınırken hata oluştu: $e';
      _isLoading = false;
      return null;
    }
  }
}
