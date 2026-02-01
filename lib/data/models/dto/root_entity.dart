class RootEntity {
  final int status;
  final Map<String, dynamic>? payload;
  final String? errorMessage;
  RootEntity({required this.status, this.payload, this.errorMessage});

  factory RootEntity.fromJson(Map<String, dynamic> json) {
    return RootEntity(
      status: json['status'],
      payload: json['payload'],
      errorMessage: json['errorMessage'],
    );
  }
}
