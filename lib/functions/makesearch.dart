import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/finddisplaytitle.dart';
import 'package:deedsuser/functions/loaddata.dart';
import 'package:deedsuser/models/search_model.dart';
import 'package:deedsuser/models/searchdetail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void makeSearch(BuildContext context) async {
  FullReportController fullReportController = Get.put(FullReportController());
  OptionSearchController optionSearchController =
      Get.put(OptionSearchController());
  JsonController jsonController = Get.put(JsonController());
  optionSearchController.searchs.clear();
  ResultSearchController resultSearchController =
      Get.put(ResultSearchController());
  resultSearchController.datarow.clear();
  resultSearchController.header.clear();
  resultSearchController.update();
  optionSearchController.searchDetail.clear();
  optionSearchController.update();
  jsonController.jsonText.value = '';
  jsonController.datarows.clear();
  jsonController.headers.clear();
  jsonController.update();
  String tempFilterItemTitle;
  var filterList = [];
  String from;
  String to;

  var dbTableName =
      fullReportController.selectedreport[0].report.scope == 'FilterForm'
          ? fullReportController.selectedreport[0].table[0].dbTableName
          : '';

  for (var filter in fullReportController.selectedreport[0].filters) {
    if (filter.textEditingController.text.isNotEmpty) {
      filterList = [];
      from = '';
      to = '';
      tempFilterItemTitle = '';
      if (filter.formItemInputType == 'Range' &&
          filter.formItemDisplayTitle.contains('از')) {
        tempFilterItemTitle = filter.formItemTitle;
        from = filter.textEditingController.text;

        for (var filter2 in fullReportController.selectedreport[0].filters) {
          if (filter2.formItemInputType == 'Range' &&
              filter2.formItemDisplayTitle.contains('تا') &&
              filter2.formItemTitle.contains(tempFilterItemTitle)) {
            to = filter2.textEditingController.text;
          }
        }
        optionSearchController.searchDetail.add(SearchDetail(
            formItemTitle: tempFilterItemTitle,
            value: filterList,
            from: from,
            to: to));
      } else if (filter.formItemInputType == 'MultiChoiceBox') {
        tempFilterItemTitle = filter.formItemTitle;
        filterList = filter.itemsTitle;
        optionSearchController.searchDetail.add(SearchDetail(
            formItemTitle: tempFilterItemTitle,
            value: filterList,
            from: from,
            to: to));
      } else if (filter.formItemInputType != 'Range') {
        filterList.add(findDisplayTitle(
            filter.textEditingController.text, filter.lookupName));
        tempFilterItemTitle = filter.formItemTitle;
        optionSearchController.searchDetail.add(SearchDetail(
            formItemTitle: tempFilterItemTitle,
            value: filterList,
            from: from,
            to: to));
      }
      optionSearchController.update();
    }
  }

  optionSearchController.searchs.clear();
  resultSearchController.resetFirstPage();
  resultSearchController.updatePageSize(10);
  resultSearchController.update();
  optionSearchController.update();
  fullReportController.selectedreport[0].report.scope == 'FilterForm'
      ? optionSearchController.searchs.add(SearchModel(
          reportName: fullReportController.selectedreport[0].report.reportName,
          dbTableName: dbTableName,
          filterFormDtoList: optionSearchController.searchDetail.toJson(),
          pageSize: resultSearchController.pageSize,
          pageNumber: resultSearchController.pageNumber,
          sortType: resultSearchController.sortType,
          sortColumn: resultSearchController.columnTitle))
      : optionSearchController.searchs.add(SearchModel(
          reportName: fullReportController.selectedreport[0].report.reportName,
          dbTableName: '',
          filterFormDtoList: optionSearchController.searchDetail.toJson(),
          pageSize: resultSearchController.pageSize,
          pageNumber: resultSearchController.pageNumber,
          sortType: resultSearchController.sortType,
          sortColumn: resultSearchController.columnTitle));
  optionSearchController.update();
  loadData(context);
}
