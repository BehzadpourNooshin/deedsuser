import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/views/widgets/columnchart.dart';
import 'package:deedsuser/views/widgets/linechart.dart';
import 'package:deedsuser/views/widgets/piechartwidget.dart';

import 'package:get/get.dart';

Future<void> makechartwidgets() async {
  ResultSearchController resultSearchController =
      Get.put(ResultSearchController());
  resultSearchController.chartWidget.clear();
  resultSearchController.update();

  for (var columnChart in resultSearchController.columnchartdatasource) {
    Map<String, double> resultMap = {};

    for (var chartData in columnChart.dataSource) {
      resultMap[chartData.x] = (resultMap[chartData.x] ?? 0) + chartData.y;
    }

    resultSearchController.chartWidget.add(
      MyColumnChartWidget(
        dataSource: columnChart.dataSource,
        title: '',
        isString: false,
      ),
    );
    resultSearchController.update();
  }

  for (var lineChart in resultSearchController.linechartdatasource) {
    resultSearchController.chartWidget.add(
      MyLineChart(
        dataSource: lineChart.dataSource,
        title: '',
        isString:
            lineChart.dataSource.first.y.runtimeType == String ? true : false,
      ),
    );
    resultSearchController.update();
  }
  for (var pieChart in resultSearchController.piechartdatasource) {
    Map<String, double> resultMap = {};

    for (var chartData in pieChart.dataSource) {
      resultMap[chartData.x] = (resultMap[chartData.x] ?? 0) + chartData.y;
    }

    List<MyPieChartData> finalData = resultMap.entries
        .map((entry) => MyPieChartData(entry.key, entry.value))
        .toList();

    resultSearchController.chartWidget.add(
      MyPieChartWidget(
        dataSource: finalData,
        title: '',
        isString:
            pieChart.dataSource.first.y.runtimeType == String ? true : false,
      ),
    );
    resultSearchController.update();
  }
}
