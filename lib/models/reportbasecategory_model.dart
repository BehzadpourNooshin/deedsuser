class ReportBaseCategoryModel {
  ReportBaseCategoryModel({
    required this.reporttitle,
    required this.reportdesc,
    required this.categoryid,
    required this.categorytitle,
    this.reportid = 0,
    required this.hasExcelExport,
    required this.hasPDFExport,
    required this.hasChart,

    // required this.table,
    // required this.filterForm,
    // required this.settings
  });

  late final String reporttitle;
  late final String reportdesc;
  late final int categoryid;
  late final String categorytitle;
  late final int reportid;
  late final bool hasExcelExport;
  late final bool hasPDFExport;
  late final bool hasChart;
  // late final List<TableModel> table;
  // late final List<FilterModel> filterForm;
  // late final List<SettingsModel> settings;
  static List<ReportBaseCategoryModel> listFromJson(dynamic json) {
    return List<ReportBaseCategoryModel>.from(json.map((reportbasecategory) =>
        ReportBaseCategoryModel.fromJson(reportbasecategory)));
  }

  Map<String, dynamic> toJson() {
    return {
      'reporttitle': reporttitle,
      'reportdesc': reportdesc,
      'categoryid': categoryid,
      'categorytitle': categorytitle,
      'reportid': reportid,
      'hasExcelExport': hasExcelExport,
      'hasPDFExport': hasPDFExport,
      'hasChart': hasChart
      // 'table': table,
      // 'filterForm': filterForm,
      // 'settings': settings,
    };
  }

  factory ReportBaseCategoryModel.fromJson(dynamic json) {
    return ReportBaseCategoryModel(
      reporttitle: json['reporttitle'],
      reportdesc: json['reportdesc'],
      categoryid: json['categoryid'],
      categorytitle: json['categorytitle'],
      reportid: json['reportid'],
      hasExcelExport: json['hasExcelExport'],
      hasPDFExport: json['hasPDFExport'],
      hasChart: json['hasChart'],
      // table: json['table'],
      // filterForm: json['filterForm'],
      // settings: json['settings'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
