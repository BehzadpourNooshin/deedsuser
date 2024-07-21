class ReportNameModel {
  ReportNameModel({
    required this.displayTitle,
    required this.reportName,
    required this.active,
  });

  late final String reportName;
  late final String displayTitle;
  late final bool active;

  static List<ReportNameModel> listFromJson(dynamic json) {
    return List<ReportNameModel>.from(
        json.map((basereport) => ReportNameModel.fromJson(basereport)));
  }

  Map<String, dynamic> toJson() {
    return {
      'displayTitle': displayTitle,
      'reportName': reportName,
      'active': active,
    };
  }

  factory ReportNameModel.fromJson(dynamic json) {
    return ReportNameModel(
      reportName: json['reportName'],
      displayTitle: json['displayTitle'],
      active: json['active'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
