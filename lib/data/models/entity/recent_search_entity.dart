class RecentSearchEntity {
  RecentSearchEntity({
    required this.uniqueId,
    required this.keyword,
    required this.searchCount,
  });

  final String? uniqueId;
  final String? keyword;
  final int? searchCount;

  factory RecentSearchEntity.fromJson(Map<String, dynamic> json) {
    return RecentSearchEntity(
      uniqueId: json["uniqueId"],
      keyword: json["keyword"],
      searchCount: json["searchCount"],
    );
  }
}
