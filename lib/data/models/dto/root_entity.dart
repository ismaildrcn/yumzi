class RootEntity {
  final int status;
  final dynamic payload;
  final RequestException? exception;
  final String? errorMessage;
  RootEntity({
    required this.status,
    this.payload,
    this.exception,
    this.errorMessage,
  });

  factory RootEntity.fromJson(Map<String, dynamic> json) {
    return RootEntity(
      status: json["status"],
      payload: json['payload'],
      exception: json['exception'] != null
          ? RequestException.fromJson(json['exception'])
          : null,
      errorMessage: json['errorMessage'],
    );
  }
}

class RequestException {
  final String path;
  final DateTime createTime;
  final String hostName;
  final dynamic message;

  RequestException({
    required this.path,
    required this.createTime,
    required this.hostName,
    required this.message,
  });

  factory RequestException.fromJson(Map<String, dynamic> json) {
    return RequestException(
      message: json['message'],
      path: json['path'],
      createTime: DateTime.parse(json['createTime']),
      hostName: json['hostName'],
    );
  }

  Map<String, dynamic>? getMessageAsMap() {
    if (message is Map) {
      return message as Map<String, dynamic>;
    }
    return null;
  }

  // Validation error'ları almak için
  List<String>? getValidationErrors(String field) {
    final messageMap = getMessageAsMap();
    if (messageMap != null && messageMap.containsKey(field)) {
      final errors = messageMap[field];
      if (errors is List) {
        return errors.cast<String>();
      }
    }
    return null;
  }
}
