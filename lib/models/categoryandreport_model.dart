import 'package:deedsuser/models/reports_model.dart';
import 'package:flutter/src/material/dropdown.dart';

class CategoryAndReportModel {
  CategoryAndReportModel({
    required this.categoryName,
    required this.reports,
  });

  late final String categoryName;
  late final List<ReportModel> reports;

  static List<CategoryAndReportModel> listFromJson(dynamic json) {
    return List<CategoryAndReportModel>.from(json.map((categoryandreport) =>
        CategoryAndReportModel.fromJson(categoryandreport)));
  }

  static List idFromTitle(String categoryTitle, json) {
    List items = [];
    dynamic jsonmap = listFromJson(json);
    for (var item in jsonmap) {
      items.add(item['categoryName']);
      items.add(item['reportName']);
      items.add(item['displayName']);
    }
    return items;
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'reports': reports,
    };
  }

  factory CategoryAndReportModel.fromJson(dynamic json) {
    return CategoryAndReportModel(
      categoryName: json['categoryName'],
      reports: json['reports'],
    );
  }

  map(DropdownMenuItem<String> Function(String reportTitle) reportId) {}

  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
