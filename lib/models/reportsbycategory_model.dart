import 'package:deedsuser/models/report_model.dart';
import 'package:flutter/src/material/dropdown.dart';

class ReportsByCategoryModel {
  ReportsByCategoryModel({
    required this.reports,
    required this.categoryName,
    required this.categoryDisplayTitle,
  });

  late final String categoryName;
  late final String categoryDisplayTitle;
  late final List<ReportNameModel> reports;

  static List<ReportsByCategoryModel> listFromJson(dynamic json) {
    return List<ReportsByCategoryModel>.from(json.map((reportsbycategory) =>
        ReportsByCategoryModel.fromJson(reportsbycategory)));
  }

  static List idFromTitle(String categoryTitle, json) {
    List items = [];
    dynamic jsonmap = listFromJson(json);
    for (var item in jsonmap) {
      items.add(item['categoryName']);
      items.add(item['categoryDisplayTitle']);
      items.add(item['reports']);
    }
    return items;
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryTitle': categoryName,
      'reports': reports,
    };
  }

  factory ReportsByCategoryModel.fromJson(dynamic json) {
    return ReportsByCategoryModel(
      categoryName: json['categoryTitle'],
      categoryDisplayTitle: json['categoryDisplayTitle'],
      reports: json['reports'],
    );
  }

  map(DropdownMenuItem<String> Function(String reportTitle) reportId) {}

  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
