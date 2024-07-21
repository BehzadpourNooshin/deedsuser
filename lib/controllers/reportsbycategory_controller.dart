import 'package:deedsuser/models/report_model.dart';
import 'package:deedsuser/models/reportsbycategory_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsByCategoryController extends GetxController {
  final categoriesLoading = false.obs;
  var selectedReportIndex = 0.obs;

  final categoryTitle = TextEditingController();
  final reportTitle = TextEditingController();
  RxList<ReportsByCategoryModel> reportsbycategory =
      <ReportsByCategoryModel>[].obs;
  RxList<ReportNameModel> allreports = <ReportNameModel>[].obs;
  RxList<ReportsByCategoryModel> reportsbycategoryshow =
      <ReportsByCategoryModel>[].obs;
  RxList<ReportsByCategoryModel> reportsbycategoryshowmarketplace =
      <ReportsByCategoryModel>[].obs;
  late RxMap<String, dynamic> objectReportDropDown;
  late bool showReport = true;
  void makeGenerateAllReports() {
    allreports.clear();
    for (var category in reportsbycategory) {
      for (var report in category.reports) {
        report.active == true
            ? allreports.add(ReportNameModel(
                displayTitle: report.displayTitle,
                reportName: report.reportName,
                active: report.active))
            : '';
      }
      update();
    }
    update();
  }
}
