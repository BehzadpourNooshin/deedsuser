class ChartReportModel {
  ChartReportModel({
    required this.reportTitle,
    required this.chartType,
    required this.chartFields,
  });
  late final String reportTitle;
  late final String chartType;
  late final List<Map<String, dynamic>> chartFields;

  static List<ChartReportModel> listFromJson(dynamic json) {
    return List<ChartReportModel>.from(
        json.map((charts) => ChartReportModel.fromJson(charts)));
  }

  Map<String, dynamic> toJson() {
    return {
      'chartType': chartType,
      'chartFields': chartFields,
      'reportTitle': reportTitle
    };
  }

  factory ChartReportModel.fromJson(dynamic json) {
    return ChartReportModel(
        chartType: json['chartType'],
        chartFields: json['chartFields'],
        reportTitle: json['reportTitle']);
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
