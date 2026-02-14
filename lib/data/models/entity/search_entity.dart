class SearchEntity {
  SearchEntity({
    required this.uniqueId,
    required this.keyword,
    required this.searchCount,
  });

  final String? uniqueId;
  final String? keyword;
  final int? searchCount;

  factory SearchEntity.fromJson(Map<String, dynamic> json) {
    return SearchEntity(
      uniqueId: json["uniqueId"],
      keyword: json["keyword"],
      searchCount: json["searchCount"],
    );
  }
}
