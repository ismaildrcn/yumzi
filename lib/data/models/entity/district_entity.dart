class DistrictEntity {
  DistrictEntity({
    required this.name,
    required this.population,
    required this.area,
  });

  final String? name;
  final int? population;
  final int? area;

  factory DistrictEntity.fromJson(Map<String, dynamic> json) {
    return DistrictEntity(
      name: json["name"],
      population: json["population"],
      area: json["area"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "population": population,
    "area": area,
  };
}
