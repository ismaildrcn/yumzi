import 'package:yumzi/data/models/entity/menu_item_entity.dart';
import 'package:yumzi/data/models/entity/restaurant_entity.dart';

class SearchEntity {
  SearchEntity({
    required this.keyword,
    required this.restaurants,
    required this.menuItems,
  });

  final String? keyword;
  final List<RestaurantEntity> restaurants;
  final List<MenuItemEntity> menuItems;

  factory SearchEntity.fromJson(Map<String, dynamic> json) {
    return SearchEntity(
      keyword: json["keyword"],
      restaurants: json["restaurants"] == null
          ? []
          : List<RestaurantEntity>.from(
              json["restaurants"]!.map((x) => RestaurantEntity.fromJson(x)),
            ),
      menuItems: json["menuItems"] == null
          ? []
          : List<MenuItemEntity>.from(
              json["menuItems"]!.map((x) => MenuItemEntity.fromJson(x)),
            ),
    );
  }
}
