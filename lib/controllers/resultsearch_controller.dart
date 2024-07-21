import 'package:deedsuser/models/chartdata_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deedsuser/models/resultsearch_model.dart';

class ResultSearchController extends GetxController {
  RxList<DataColumn> header = <DataColumn>[].obs;
  RxList<DataRow> datarow = <DataRow>[].obs;
  RxList<DataColumn> headerForProperties = <DataColumn>[].obs;
  RxList<DataRow> datarowForProperties = <DataRow>[].obs;
  RxList<ColumnChartModel> columnchartdatasource = <ColumnChartModel>[].obs;
  RxList<LineChartModel> linechartdatasource = <LineChartModel>[].obs;
  RxList<PieChartModel> piechartdatasource = <PieChartModel>[].obs;
  RxList<Widget> chartWidget = <Widget>[].obs;
  RxList<ResultSearchModel> result = <ResultSearchModel>[].obs;
  RxList<ResultSearchModel> resultForProperties = <ResultSearchModel>[].obs;
  TextEditingController pn = TextEditingController();
  TextEditingController ps = TextEditingController();
  RxInt pageNumber = 0.obs;
  int pageNumberProperties = 0;
  RxInt pageSize = 9.obs;
  bool isAdd = false;
  int index = 0;
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
    pageNumber = pageNumber + i;

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
  RxString sortType = ''.obs;
  RxInt columnIndex = 0.obs;
  RxString columnTitle = ''.obs;
  RxString sortColumn = ''.obs;
  RxBool _sortAscending = false.obs;
  void sortByColumn(columnIndex, _sortAscending) {
    columnTitle = headers[columnIndex];
    if (_sortAscending) {
      sortType = 'asc'.obs;
      this._sortAscending.value = !_sortAscending;
    } else {
      sortType = 'desc'.obs;
      this._sortAscending.value = !_sortAscending;
    }
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
