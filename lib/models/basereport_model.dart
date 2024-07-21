class BaseReportModel {
  BaseReportModel({
    required this.reportDescription,
    required this.reportName,
    required this.reportCategory,
    required this.reportQueryFileName,
    required this.hasExcelExport,
    required this.hasPDFExport,
    required this.hasChart,
    required this.hasRefreshQuery,
    required this.hasViewInHomePage,
    required this.hasSwagger,
    required this.hasUserPdfExport,
    required this.hasUserExcelExport,
    required this.hasUserChartView,
    required this.displayTitle,
    required this.scope,
  });

  late final String reportDescription;
  late final String reportName;
  late final String reportCategory;
  late final String reportQueryFileName;
  late final String hasExcelExport;
  late final String hasPDFExport;
  late final String hasChart;
  late final String hasRefreshQuery;
  late final String hasViewInHomePage;
  late final String hasSwagger;
  late final bool hasUserPdfExport;
  late final bool hasUserExcelExport;
  late final bool hasUserChartView;
  late final String displayTitle;
  late final String scope;
  static List<BaseReportModel> listFromJson(dynamic json) {
    return List<BaseReportModel>.from(
        json.map((basereport) => BaseReportModel.fromJson(basereport)));
  }

  Map<String, dynamic> toJson() {
    return {
      'reportDescription': reportDescription,
      'reportName': reportName,
      'reportCategory': reportCategory,
      'reportQueryFileName': reportQueryFileName,
      'hasPDFExport': hasPDFExport,
      'hasChart': hasChart,
      'hasRefreshQuery': hasRefreshQuery,
      'hasViewInHomePage': hasViewInHomePage,
      'hasSwagger': hasSwagger,
      'hasUserPdfExport': hasUserPdfExport,
      'hasUserExcelExport': hasUserExcelExport,
      'hasUserChartView': hasUserChartView,
      'displayTitle': displayTitle,
      'scope': scope,
    };
  }

  factory BaseReportModel.fromJson(dynamic json) {
    return BaseReportModel(
      reportDescription: json['reportDescription'],
      reportName: json['reportName'],
      reportCategory: json['reportCategory'],
      reportQueryFileName: json['reportQueryFileName'],
      hasPDFExport: json['hasPDFExport'],
      hasChart: json['hasChart'],
      hasRefreshQuery: json['hasRefreshQuery'],
      hasViewInHomePage: json['hasViewInHomePage'],
      hasSwagger: json['hasSwagger'],
      hasExcelExport: json['hasExcelExport'],
      displayTitle: json['displayTitle'],
      hasUserPdfExport: json['hasUserPdfExport'],
      hasUserExcelExport: json['hasUserExcelExport'],
      hasUserChartView: json['hasUserChartView'],
      scope: json['scope'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
