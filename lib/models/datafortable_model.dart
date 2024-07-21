class DataForTableModel {
  DataForTableModel(
      {required this.offset,
      required this.limit,
      required this.datatablename,
      required this.search,
      this.result = const []});

  late final int offset;
  late final int limit;
  late final String datatablename;
  late final List<Map<String, dynamic>> search;
  late List result;

  static List<DataForTableModel> listFromJson(dynamic json) {
    return List<DataForTableModel>.from(
        json.map((data) => DataForTableModel.fromJson(data)));
  }

  Map<String, dynamic> toJson() {
    return {
      'offset': offset,
      'limit': limit,
      'datatablename': datatablename,
      'search': search,
      'result': result
    };
  }

  factory DataForTableModel.fromJson(dynamic json) {
    return DataForTableModel(
        offset: json['offset'],
        limit: json['limit'],
        search: json['search'],
        result: json['result'],
        datatablename: json['datatablename']);
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
