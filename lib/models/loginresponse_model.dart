class LoginResponseModel {
  LoginResponseModel({
    required this.code,
    required this.accesstoken,
    required this.refreshtoken,
  });

  late final String code;
  late final String accesstoken;
  late final String refreshtoken;

  // late final String role;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'accesstoken': accesstoken,
      'refreshtoken': refreshtoken,
    };
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> map) {
    return LoginResponseModel(
      code: map['code'],
      accesstoken: map['accesstoken'],
      refreshtoken: map['refreshtoken'],
    );
  }
}
