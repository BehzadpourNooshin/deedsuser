import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/models/search_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> loadDataForProperties(BuildContext context) async {
  ResultSearchController resultSearchController =
      Get.put(ResultSearchController());
  ErrorhandelingController errorhandelingController =
      Get.put(ErrorhandelingController());
  OptionSearchController optionSearchController =
      Get.put(OptionSearchController());
  FullReportController fullReportController = Get.put(FullReportController());
  resultSearchController.pageNumberProperties = 0;
  optionSearchController.searchForProperties.clear();
  resultSearchController.resultForProperties.clear();
  resultSearchController.columnchartdatasource.clear();
  resultSearchController.piechartdatasource.clear();
  resultSearchController.linechartdatasource.clear();
  resultSearchController.chartWidget.clear();

  resultSearchController.update();
  optionSearchController.update();
  optionSearchController.searchForProperties.add(SearchModel(
      reportName: fullReportController.selectedreport[0].report.reportName,
      dbTableName: fullReportController.selectedreport[0].table[0].dbTableName,
      filterFormDtoList: optionSearchController.searchDetail.toJson(),
      pageSize: resultSearchController.result[0].totalElements.obs,
      pageNumber: 0.obs,
      sortType: resultSearchController.sortType,
      sortColumn: resultSearchController.columnTitle));
  optionSearchController.update();

  // Create a list of charts to display in the PageView

  final loginResponseController = Get.find<LoginResponseController>();

  // ignore: unused_local_variable

  if (optionSearchController.searchForProperties.isNotEmpty) {
    if (fullReportController.selectedreport[0].report.scope == 'FilterForm') {
      await Network()
          .getDataForProperties(
        optionSearchController: optionSearchController,
        accessToken: loginResponseController.accesstoken.text,
      )
          .then((value) async {
        if (!value) {
          errorhandelingController.errorTitleMessage.value == 'خطای نشست'
              ? {await loginResponseController.logout(409)}
              : errorhandelingController.errorTitleMessage.value == 'خطای توکن'
                  ? {await loginResponseController.logout(401)}
                  : Network.showInternetError(
                      context,
                      errorhandelingController.errorSubTitleMessage.value,
                    );
        }
      });
    }
  }
}
