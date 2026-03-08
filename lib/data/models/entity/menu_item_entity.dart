import 'package:yumzi/data/models/entity/restaurant_entity.dart';
import 'package:yumzi/data/models/enums/currency_type.dart';

class MenuItemEntity {
  MenuItemEntity({
    required this.uniqueId,
    required this.name,
    required this.description,
    required this.slug,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.currency,
    required this.stockQuantity,
    required this.minimumOrderQuantity,
    required this.maximumOrderQuantity,
    required this.preparationTime,
    required this.sortOrder,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.calories,
    required this.proteinGrams,
    required this.carbohydrateGrams,
    required this.fatGrams,
    required this.favorite,
    required this.allergens,
    required this.restaurant,
  });

  final String? uniqueId;
  final String? name;
  final String? description;
  final String? slug;
  final double? price;
  final double? discountPrice;
  final double? discountPercentage;
  final CurrencyType? currency;
  final int? stockQuantity;
  final int? minimumOrderQuantity;
  final int? maximumOrderQuantity;
  final String? preparationTime;
  final int? sortOrder;
  final String? imageUrl;
  final String? thumbnailUrl;
  final int? calories;
  final double? proteinGrams;
  final double? carbohydrateGrams;
  final double? fatGrams;
  final bool? favorite;
  final Allergens? allergens;
  final RestaurantEntity? restaurant;

  factory MenuItemEntity.fromJson(Map<String, dynamic> json) {
    return MenuItemEntity(
      uniqueId: json["uniqueId"],
      name: json["name"],
      description: json["description"],
      slug: json["slug"],
      price: json["price"],
      discountPrice: json["discountPrice"],
      discountPercentage: json["discountPercentage"],
      currency: json["currency"] == null
          ? null
          : CurrencyType.values.firstWhere((e) => e.value == json["currency"]),
      stockQuantity: json["stockQuantity"],
      minimumOrderQuantity: json["minimumOrderQuantity"],
      maximumOrderQuantity: json["maximumOrderQuantity"],
      preparationTime: json["preparationTime"],
      sortOrder: json["sortOrder"],
      imageUrl: json["imageUrl"],
      thumbnailUrl: json["thumbnailUrl"],
      calories: json["calories"],
      proteinGrams: json["proteinGrams"],
      carbohydrateGrams: json["carbohydrateGrams"],
      fatGrams: json["fatGrams"],
      favorite: json["favorite"],
      allergens: json["allergens"] == null
          ? null
          : Allergens.fromJson(json["allergens"]),
      restaurant: json["restaurant"] == null
          ? null
          : RestaurantEntity.fromJson(json["restaurant"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "uniqueId": uniqueId,
    "name": name,
    "description": description,
    "slug": slug,
    "price": price,
    "discountPrice": discountPrice,
    "discountPercentage": discountPercentage,
    "currency": currency?.value,
    "stockQuantity": stockQuantity,
    "minimumOrderQuantity": minimumOrderQuantity,
    "maximumOrderQuantity": maximumOrderQuantity,
    "preparationTime": preparationTime,
    "sortOrder": sortOrder,
    "imageUrl": imageUrl,
    "thumbnailUrl": thumbnailUrl,
    "calories": calories,
    "proteinGrams": proteinGrams,
    "carbohydrateGrams": carbohydrateGrams,
    "fatGrams": fatGrams,
    "favorite": favorite,
    "allergens": allergens?.toJson(),
    "restaurant": restaurant?.toJson(),
  };
}

class Allergens {
  Allergens({
    required this.gluten,
    required this.eggs,
    required this.soy,
    required this.peanuts,
    required this.treeNuts,
    required this.dairy,
    required this.fish,
    required this.shellfish,
  });

  final bool? gluten;
  final bool? eggs;
  final bool? soy;
  final bool? peanuts;
  final bool? treeNuts;
  final bool? dairy;
  final bool? fish;
  final bool? shellfish;

  factory Allergens.fromJson(Map<String, dynamic> json) {
    return Allergens(
      gluten: json["gluten"],
      eggs: json["eggs"],
      soy: json["soy"],
      peanuts: json["peanuts"],
      treeNuts: json["treeNuts"],
      dairy: json["dairy"],
      fish: json["fish"],
      shellfish: json["shellfish"],
    );
  }

  Map<String, dynamic> toJson() => {
    "gluten": gluten,
    "eggs": eggs,
    "soy": soy,
    "peanuts": peanuts,
    "treeNuts": treeNuts,
    "dairy": dairy,
    "fish": fish,
    "shellfish": shellfish,
  };
}
