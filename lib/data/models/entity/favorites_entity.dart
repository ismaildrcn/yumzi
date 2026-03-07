import 'package:yumzi/data/models/entity/menu_item_entity.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';

class FavoritesEntity {
  final List<MenuItemEntity> favoriteItems;
  final List<RestaurantEntity> favoriteRestaurants;

  FavoritesEntity({
    required this.favoriteItems,
    required this.favoriteRestaurants,
  });

  factory FavoritesEntity.fromJson(Map<String, dynamic> json) {
    return FavoritesEntity(
      favoriteItems:
          (json['favoriteItems'] as List<dynamic>?)
              ?.map((item) => MenuItemEntity.fromJson(item))
              .toList() ??
          [],
      favoriteRestaurants:
          (json['favoriteRestaurants'] as List<dynamic>?)
              ?.map((item) => RestaurantEntity.fromJson(item))
              .toList() ??
          [],
    );
  }
}
