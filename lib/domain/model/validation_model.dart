class ValidationModel {
  int code;
  String expiresIn;
  String message;

  ValidationModel({
    required this.code,
    required this.expiresIn,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': code,
      'expiresIn': expiresIn,
    };
  }

  factory ValidationModel.fromJson(Map<String, dynamic> map) {
    return ValidationModel(
      code: map['code'] ?? 0,
      expiresIn: map['expiresIn'] ?? '',
      message: map['message'] ?? '',
    );
  }

  factory ValidationModel.empty() {
    return ValidationModel.fromJson({});
  }
}
