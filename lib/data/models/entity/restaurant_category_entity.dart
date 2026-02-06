class RestaurantCategoryEntity {
  RestaurantCategoryEntity({
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

  factory RestaurantCategoryEntity.fromJson(Map<String, dynamic> json) {
    return RestaurantCategoryEntity(
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
