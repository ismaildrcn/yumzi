class ProvinceEntity {
  final String? name;
  final int? population;
  final int? area;
  final int? altitude;
  final bool? isCoastal;
  final bool? isMetropolitan;
  final double? latitude;
  final double? longitude;
  final String? googleMapsUrl;
  final String? openstreetmapUrl;
  final Region? region;

  ProvinceEntity({
    required this.name,
    required this.population,
    required this.area,
    required this.altitude,
    required this.isCoastal,
    required this.isMetropolitan,
    required this.latitude,
    required this.longitude,
    required this.googleMapsUrl,
    required this.openstreetmapUrl,
    required this.region,
  });

  factory ProvinceEntity.fromJson(Map<String, dynamic> json) {
    return ProvinceEntity(
      name: json["name"],
      population: json["population"],
      area: json["area"],
      altitude: json["altitude"],
      isCoastal: json["isCoastal"],
      isMetropolitan: json["isMetropolitan"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      googleMapsUrl: json["googleMapsUrl"],
      openstreetmapUrl: json["openstreetmapUrl"],
      region: json["region"] == null ? null : Region.fromJson(json["region"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "population": population,
    "area": area,
    "altitude": altitude,
    "isCoastal": isCoastal,
    "isMetropolitan": isMetropolitan,
    "latitude": latitude,
    "longitude": longitude,
    "googleMapsUrl": googleMapsUrl,
    "openstreetmapUrl": openstreetmapUrl,
    "region": region?.toJson(),
  };
}

class Region {
  Region({required this.nameTr, required this.nameEn});

  final String? nameTr;
  final String? nameEn;

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(nameTr: json["nameTr"], nameEn: json["nameEn"]);
  }

  Map<String, dynamic> toJson() => {"nameTr": nameTr, "nameEn": nameEn};
}
