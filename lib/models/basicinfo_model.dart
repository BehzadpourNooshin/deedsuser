class BasicDashboardInfoModel {
  BasicDashboardInfoModel(
      {required this.numberOfUsers,
      required this.numberOfReports,
      required this.numberOfCategories,
      required this.numberOfOnlineUsers,
      required this.numberOfUpdateNotes});

  late final int numberOfUsers;
  late final int numberOfReports;
  late final int numberOfCategories;
  late final int numberOfOnlineUsers;
  late final int numberOfUpdateNotes;
  static List<BasicDashboardInfoModel> listFromJson(dynamic json) {
    return List<BasicDashboardInfoModel>.from(
        json.map((basicInfo) => BasicDashboardInfoModel.fromJson(basicInfo)));
  }

  factory BasicDashboardInfoModel.fromJson(dynamic json) {
    return BasicDashboardInfoModel(
      numberOfUsers: json['numberOfUsers'],
      numberOfReports: json['numberOfReports'],
      numberOfCategories: json['numberOfCategories'],
      numberOfOnlineUsers: json['numberOfOnlineUsers'],
      numberOfUpdateNotes: json['numberOfUpdateNotes'],
    );
  }

  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
