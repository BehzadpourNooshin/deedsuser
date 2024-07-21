class AccountModel {
  AccountModel(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.address,
      required this.mobileNumber,
      required this.gender,
      required this.active,
      required this.hasExcelExport,
      required this.hasPDFExport,
      required this.hasChart,
      required this.role});

  late final String firstname;
  late final String lastname;
  late final String email;
  late final String password;
  late final String address;
  late final String mobileNumber;
  late final String gender;
  late final bool active;
  late final bool hasExcelExport;
  late final bool hasPDFExport;
  late final bool hasChart;
  late final String role;

  static List<AccountModel> listFromJson(dynamic json) {
    return List<AccountModel>.from(
        json.map((user) => AccountModel.fromJson(user)));
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'address': address,
      'mobileNumber': mobileNumber,
      'gender': gender,
      'active': active,
      'hasExcelExport': hasExcelExport,
      'hasPDFExport': hasPDFExport,
      'hasChart': hasChart,
      'role': role,
    };
  }

  factory AccountModel.fromJson(dynamic json) {
    return AccountModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      mobileNumber: json['mobileNumber'],
      gender: json['gender'],
      role: json['role'],
      active: json['active'],
      hasExcelExport: json['hasExcelExport'],
      hasChart: json['hasChart'],
      hasPDFExport: json['hasPDFExport'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}

class TempRecentUsers {
  final String? firstname,
      lastname,
      email,
      password,
      address,
      mobileNumber,
      gender,
      role;

  TempRecentUsers(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.address,
      this.mobileNumber,
      this.gender,
      this.role});
}

List demoRecentUsers = [
  TempRecentUsers(
      firstname: "نوشین ",
      lastname: "بهزادپور",
      email: "n.behzadpour@tci.ir",
      password: "Qazxsw!@#456",
      address: "خیابان دامن افشار",
      mobileNumber: "09191777246",
      gender: "FEMALE",
      role: "USER"),
  TempRecentUsers(
      firstname: "آرزو ",
      lastname: "محمدی",
      email: "a.mohamadi@tci.ir",
      password: "Qazxsw!@#456",
      address: "خیابان دامن افشار",
      mobileNumber: "09191777246",
      gender: "FEMALE",
      role: "USER"),
  TempRecentUsers(
      firstname: "امیررضا ",
      lastname: "مغازه‌ای",
      email: "a.maghaze@tci.ir",
      password: "Qazxsw!@#456",
      address: "خیابان دامن افشار",
      mobileNumber: "09191777246",
      gender: "MALE",
      role: "USER"),
];
