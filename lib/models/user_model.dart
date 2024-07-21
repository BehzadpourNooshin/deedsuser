class UserModel {
  UserModel({
    required this.email,
    required this.password,
    required this.role,
    required this.accesstoken,
    required this.refreshtoken,
    required this.firstlogin,
    required this.expirytoken,
    required this.expirytime,
    // , required this.role
  });

  late final String email;
  late final String password;
  late final String role;
  late final String accesstoken;
  late final String refreshtoken;
  late final String firstlogin;
  late final int expirytoken;
  late final String expirytime;
  // late final String role;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
      'accesstoken': accesstoken,
      'refreshtoken': refreshtoken,
      'firstlogin': firstlogin,
      'expirytoken': expirytoken,
      'expirytime': expirytime,
    };
  }

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      role: json['role'],
      accesstoken: json['accesstoken'],
      refreshtoken: json['refreshtoken'],
      firstlogin: json['firstlogin'],
      expirytoken: json['expirytoken'],
      expirytime: json['expirytime'],
    );
  }
}
