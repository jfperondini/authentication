class ServerException implements Exception {
  String message;
  ServerException({required this.message});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory ServerException.fromJson(Map<String, dynamic> map) {
    return ServerException(
      message: map['message'] ?? '',
    );
  }

  factory ServerException.empty() {
    return ServerException.fromJson({});
  }
}
