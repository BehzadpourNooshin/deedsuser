import 'package:deedsuser/models/basereport_model.dart';
import 'package:deedsuser/models/charts_model.dart';
import 'package:deedsuser/models/filters_models.dart';
import 'package:deedsuser/models/tables_model.dart';

class FullReportModel {
  FullReportModel({
    required this.report,
    required this.table,
    this.chart = const <ChartModel>[],
    required this.filters,
    // required this.table,
    // required this.filterForm,
    // required this.settings
  });

  late final BaseReportModel report;
  late final List<TableModel> table;
  late List<ChartModel> chart;
  late final List<FilterModel> filters;
  // late final List<TableModel> table;
  // late final List<FilterModel> filterForm;
  // late final List<SettingsModel> settings;

  static List<FullReportModel> listFromJson(dynamic json) {
    return List<FullReportModel>.from(
        json.map((report) => FullReportModel.fromJson(report)));
  }

  Map<String, dynamic> toJson() {
    return {
      'report': report,
      'table': table,
      'chart': chart,
      'filters': filters,

      // 'table': table,
      // 'filterForm': filterForm,
      // 'settings': settings,
    };
  }

  factory FullReportModel.fromJson(dynamic json) {
    return FullReportModel(
      report: json['report'],
      table: json['table'],
      chart: json['chart'],
      filters: json['filters'],
      // table: json['table'],
      // filterForm: json['filterForm'],
      // settings: json['settings'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}

class SettingsModel {}
