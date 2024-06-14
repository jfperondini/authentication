class UserModel {
  String? uuid;
  String? firstName;
  String? lastName;
  String? email;
  String? message;

  UserModel({
    this.uuid,
    this.firstName,
    this.lastName,
    this.email,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uuid: map['uuid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      message: map['message'] ?? '',
    );
  }

  factory UserModel.empaty() {
    return UserModel.fromJson({});
  }
}
