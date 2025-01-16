import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/table_controller.dart';
import 'package:deedsuser/models/chartdata_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deedsuser/models/resultsearch_model.dart';

class ResultSearchController extends GetxController {
  var clipBoardData = ''.obs;
  var copyIndex = 0.obs;
  RxList<DataColumn> header = <DataColumn>[].obs;
  RxList<DataRow> datarow = <DataRow>[].obs;
  RxList<DataColumn> headerForProperties = <DataColumn>[].obs;
  RxList<DataRow> datarowForProperties = <DataRow>[].obs;
  RxList<ColumnChartModel> columnchartdatasource = <ColumnChartModel>[].obs;
  RxList<LineChartModel> linechartdatasource = <LineChartModel>[].obs;
  RxList<PieChartModel> piechartdatasource = <PieChartModel>[].obs;
  RxList<BarChartModel> barchartdatasource = <BarChartModel>[].obs;
  RxList<Widget> chartWidget = <Widget>[].obs;
  RxList<ResultSearchModel> result = <ResultSearchModel>[].obs;
  RxList<ResultSearchModel> resultForProperties = <ResultSearchModel>[].obs;
  TextEditingController pn = TextEditingController();
  TextEditingController ps = TextEditingController();
  RxInt pageNumber = 0.obs;
  int pageNumberProperties = 0;
  RxInt pageSize = 10.obs;
  bool isAdd = false;
  int index = 0;
  void setClipboardData(String data, int i) {
    clipBoardData.value = data;
    copyIndex.value = i;
  }

  void previousPage() {
    if (pageNumber > 0) {
      pageNumber = pageNumber - 1;
      pn.text = pageNumber.toString();
      update();
    }
  }

  void nextPage() {
    pageNumber = pageNumber + 1;
    if (kDebugMode) {
      print(pageNumber);
    }
    update();
  }

  void updatePageSize(int newPageSize) {
    pageSize = newPageSize.obs;

    update();
  }

  void updatePage(int i) {
    pageNumber.value = i;

    update();
  }

  void resetFirstPage() {
    pageNumber.value = 0;

    update();
  }

  void resetLastPage(int i) {
    pageNumber.value = i;

    update();
  }

  List headers = [].obs;
  List datarows = [].obs;
  List headersForProperties = [].obs;
  List datarowsForProperties = [].obs;
  RxBool isWaiting = false.obs;
  RxString sortType = 'ASC'.obs;
  RxInt columnIndex = 0.obs;
  RxString columnTitle = ''.obs;
  RxString sortColumn = ''.obs;
  final RxBool sortAscending = false.obs;
  void sortByColumn(columnIndex, selectedSort, booleanSortAscending) {
    FullReportController fullReportController = Get.put(FullReportController());
    var table = fullReportController.selectedreport[0].table[0];
    for (var column in table.fields) {
      if (column.columnTitle.toString().toLowerCase().replaceAll(' ', '') ==
          headers[columnIndex].toString().toLowerCase().replaceAll(' ', '')) {
        sortColumn.value = column.columnDBFieldName;
      }
    }

    sortType.value = selectedSort;
    sortAscending.value = booleanSortAscending;
    update();
  }

  void waitUpdate() {
    if (datarows.isEmpty) {
      isWaiting = RxBool(true);
    } else {
      isWaiting = RxBool(false);
    }
    update();
  }
}
