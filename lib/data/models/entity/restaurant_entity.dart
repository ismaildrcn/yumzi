import 'package:yumzi/data/models/enums/menu_category_type.dart';

class RestaurantEntity {
  RestaurantEntity({
    required this.uniqueId,
    required this.name,
    required this.slug,
    required this.description,
    required this.phoneNumber,
    required this.email,
    required this.website,
    required this.openingHours,
    required this.deliveryTimeRange,
    required this.minimumOrderAmount,
    required this.deliveryFee,
    required this.deliveryRadiusKm,
    required this.rating,
    required this.reviewCount,
    required this.orderCount,
    required this.logoUrl,
    required this.coverImageUrl,
    required this.taxNumber,
    required this.category,
    required this.cuisine,
    required this.address,
    required this.acceptingOrders,
    required this.active,
    required this.featured,
    required this.menuCategories,
  });

  final String? uniqueId;
  final String? name;
  final String? slug;
  final String? description;
  final String? phoneNumber;
  final String? email;
  final String? website;
  final OpeningHours? openingHours;
  final String? deliveryTimeRange;
  final double? minimumOrderAmount;
  final double? deliveryFee;
  final double? deliveryRadiusKm;
  final double? rating;
  final int? reviewCount;
  final int? orderCount;
  final String? logoUrl;
  final String? coverImageUrl;
  final String? taxNumber;
  final Category? category;
  final Category? cuisine;
  final dynamic address;
  final bool? acceptingOrders;
  final bool? active;
  final bool? featured;
  final List<MenuCategory>? menuCategories;

  factory RestaurantEntity.fromJson(Map<String, dynamic> json) {
    return RestaurantEntity(
      uniqueId: json["uniqueId"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
      website: json["website"],
      openingHours: json["openingHours"] == null
          ? null
          : OpeningHours.fromJson(json["openingHours"]),
      deliveryTimeRange: json["deliveryTimeRange"],
      minimumOrderAmount: json["minimumOrderAmount"],
      deliveryFee: json["deliveryFee"],
      deliveryRadiusKm: json["deliveryRadiusKm"],
      rating: json["rating"],
      reviewCount: json["reviewCount"],
      orderCount: json["orderCount"],
      logoUrl: json["logoUrl"],
      coverImageUrl: json["coverImageUrl"],
      taxNumber: json["taxNumber"],
      category: json["category"] == null
          ? null
          : Category.fromJson(json["category"]),
      cuisine: json["cuisine"] == null
          ? null
          : Category.fromJson(json["cuisine"]),
      address: json["address"],
      acceptingOrders: json["acceptingOrders"],
      active: json["active"],
      featured: json["featured"],
      menuCategories: json["menuCategories"] == null
          ? null
          : List<MenuCategory>.from(
              json["menuCategories"].map((x) => MenuCategory.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "uniqueId": uniqueId,
    "name": name,
    "slug": slug,
    "description": description,
    "phoneNumber": phoneNumber,
    "email": email,
    "website": website,
    "openingHours": openingHours?.toJson(),
    "deliveryTimeRange": deliveryTimeRange,
    "minimumOrderAmount": minimumOrderAmount,
    "deliveryFee": deliveryFee,
    "deliveryRadiusKm": deliveryRadiusKm,
    "rating": rating,
    "reviewCount": reviewCount,
    "orderCount": orderCount,
    "logoUrl": logoUrl,
    "coverImageUrl": coverImageUrl,
    "taxNumber": taxNumber,
    "category": category?.toJson(),
    "cuisine": cuisine?.toJson(),
    "address": address,
    "acceptingOrders": acceptingOrders,
    "active": active,
    "featured": featured,
    "menuCategories": menuCategories?.map((x) => x.toJson()).toList(),
  };
}

class Category {
  Category({
    required this.uniqueId,
    required this.name,
    required this.slug,
    required this.description,
    required this.iconUrl,
    required this.sortOrder,
  });

  final String? uniqueId;
  final String? name;
  final String? slug;
  final String? description;
  final String? iconUrl;
  final int? sortOrder;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      uniqueId: json["uniqueId"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      iconUrl: json["iconUrl"],
      sortOrder: json["sortOrder"],
    );
  }

  Map<String, dynamic> toJson() => {
    "uniqueId": uniqueId,
    "name": name,
    "slug": slug,
    "description": description,
    "iconUrl": iconUrl,
    "sortOrder": sortOrder,
  };
}

class OpeningHours {
  OpeningHours({required this.schedule});

  final Schedule? schedule;

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      schedule: json["schedule"] == null
          ? null
          : Schedule.fromJson(json["schedule"]),
    );
  }

  Map<String, dynamic> toJson() => {"schedule": schedule?.toJson()};
}

class Schedule {
  Schedule({
    required this.friday,
    required this.monday,
    required this.sunday,
    required this.tuesday,
    required this.saturday,
    required this.thursday,
    required this.wednesday,
  });

  final Day? friday;
  final Day? monday;
  final Day? sunday;
  final Day? tuesday;
  final Day? saturday;
  final Day? thursday;
  final Day? wednesday;

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      friday: json["friday"] == null ? null : Day.fromJson(json["friday"]),
      monday: json["monday"] == null ? null : Day.fromJson(json["monday"]),
      sunday: json["sunday"] == null ? null : Day.fromJson(json["sunday"]),
      tuesday: json["tuesday"] == null ? null : Day.fromJson(json["tuesday"]),
      saturday: json["saturday"] == null
          ? null
          : Day.fromJson(json["saturday"]),
      thursday: json["thursday"] == null
          ? null
          : Day.fromJson(json["thursday"]),
      wednesday: json["wednesday"] == null
          ? null
          : Day.fromJson(json["wednesday"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "friday": friday?.toJson(),
    "monday": monday?.toJson(),
    "sunday": sunday?.toJson(),
    "tuesday": tuesday?.toJson(),
    "saturday": saturday?.toJson(),
    "thursday": thursday?.toJson(),
    "wednesday": wednesday?.toJson(),
  };
}

class Day {
  Day({required this.open, required this.close, required this.closed});

  final String? open;
  final String? close;
  final bool? closed;

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      open: json["open"],
      close: json["close"],
      closed: json["closed"],
    );
  }

  Map<String, dynamic> toJson() => {
    "open": open,
    "close": close,
    "closed": closed,
  };
}

class MenuCategory {
  MenuCategory({
    required this.uniqueId,
    required this.name,
    required this.description,
    required this.slug,
    required this.imageUrl,
    required this.sortOrder,
    required this.isActive,
    required this.isFeatured,
    required this.categoryType,
  });

  final String? uniqueId;
  final String? name;
  final String? description;
  final String? slug;
  final String? imageUrl;
  final int? sortOrder;
  final bool? isActive;
  final bool? isFeatured;
  final MenuCategoryType? categoryType;

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      uniqueId: json["uniqueId"],
      name: json["name"],
      description: json["description"],
      slug: json["slug"],
      imageUrl: json["imageUrl"],
      sortOrder: json["sortOrder"],
      isActive: json["isActive"],
      isFeatured: json["isFeatured"],
      categoryType: json['categoryType'] != null
          ? MenuCategoryType.values.firstWhere(
              (e) => e.value == json['categoryType'],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "uniqueId": uniqueId,
    "name": name,
    "description": description,
    "slug": slug,
    "imageUrl": imageUrl,
    "sortOrder": sortOrder,
    "isActive": isActive,
    "isFeatured": isFeatured,
    "categoryType": categoryType?.value,
  };
}
