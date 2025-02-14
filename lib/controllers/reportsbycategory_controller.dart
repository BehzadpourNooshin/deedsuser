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
  var openCategory = ''.obs; // ذخیره دسته‌بندی باز شده
  var selectedReport = ''.obs; // ذخیره گزارش انتخاب‌شده

  // تابع برای باز و بسته کردن دسته‌بندی
  void toggleCategory(String categoryTitle) {
    if (openCategory.value == categoryTitle) {
      openCategory.value = ''; // بستن دسته‌بندی
    } else {
      openCategory.value = categoryTitle; // باز کردن دسته‌بندی
    }
  }

  void resetOpenCategory() {
    openCategory.value = ''; // یا هر مقدار دلخواه
  }

  // تابع برای انتخاب گزارش
  void selectReport(String reportName) {
    selectedReport.value = reportName;
  }

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
