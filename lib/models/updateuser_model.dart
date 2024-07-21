class UpdateUserModel {
  UpdateUserModel({
    required this.email,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.gender,
    required this.mobileNumber,
    required this.refreshtoken,
    // , required this.role
  });

  late final String email;
  late final String password;
  late final String firstname;
  late final String lastname;
  late final String address;
  late final String gender;
  late final String mobileNumber;
  late final String refreshtoken;

  // late final String role;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'gender': gender,
      'mobileNumber': mobileNumber,
      'refreshtoken': refreshtoken,
    };
  }

  factory UpdateUserModel.fromJson(dynamic json) {
    return UpdateUserModel(
      email: json['email'],
      password: json['password'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
      gender: json['gender'],
      refreshtoken: json['refreshtoken'],
      mobileNumber: json['mobileNumber'],
    );
  }
}
