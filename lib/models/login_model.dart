class LoginModel {
  LoginModel({
    required this.email,
    required this.password,
    required this.role,
  });

  late final String email;
  late final String password;
  late final String role;

  // late final String role;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory LoginModel.fromJson(dynamic json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }
}
