import 'package:flutter/src/material/dropdown.dart';

class CategoryModel {
  CategoryModel(
      {required this.categoryTitle,
      required this.categoryId,
      required this.reporttitles,
      required this.reportid,
      required this.hasExcelExport,
      required this.hasPDFExport,
      required this.hasChart,
      required this.reportObject});

  late final String categoryTitle;
  late final int categoryId;
  late final List reporttitles;
  late final List reportid;
  late final List reportObject;
  late final bool hasExcelExport;
  late final bool hasPDFExport;
  late final bool hasChart;

  static List<CategoryModel> listFromJson(dynamic json) {
    return List<CategoryModel>.from(
        json.map((category) => CategoryModel.fromJson(category)));
  }

  static List idFromTitle(String categoryTitle, json) {
    List items = [];
    dynamic jsonmap = listFromJson(json);
    for (var item in jsonmap) {
      items.add(item['categoryId']);
    }
    return items;
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryTitle': categoryTitle,
      'categoryId': categoryId,
      'reportid': reportid,
      'reporttitles': reporttitles,
      'hasExcelExport': hasExcelExport,
      'hasChart': hasChart,
      'hasPDFExport': hasPDFExport,
      'reportObject': reportObject,
    };
  }

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryTitle: json['categoryTitle'],
      reporttitles: json['reporttitles'],
      reportid: json['reportid'],
      hasExcelExport: json['hasExcelExport'],
      hasChart: json['hasChart'],
      hasPDFExport: json['hasPDFExport'],
      reportObject: json['reportObject'],
    );
  }

  map(DropdownMenuItem<String> Function(String reportTitle) reportId) {}

  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
