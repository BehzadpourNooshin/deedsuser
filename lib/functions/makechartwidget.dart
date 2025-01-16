import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/views/widgets/barchart.dart';
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
    resultSearchController.chartWidget.add(
      MyColumnChartWidget(
        dataSource: columnChart.dataSource,
        title: columnChart.title,
        isString: false,
      ),
    );
    resultSearchController.update();
  }

  for (var lineChart in resultSearchController.linechartdatasource) {
    resultSearchController.chartWidget.add(
      MyLineChartWidget(
        dataSource: lineChart.dataSource,
        title: lineChart.title,
        isString: false,
      ),
    );
    resultSearchController.update();
  }
  for (var pieChart in resultSearchController.piechartdatasource) {
    resultSearchController.chartWidget.add(
      MyPieChartWidget(
        dataSource: pieChart.dataSource,
        title: pieChart.title,
        isString:
            pieChart.dataSource.first.y.runtimeType == String ? true : false,
      ),
    );
    resultSearchController.update();
  }
  for (var barChart in resultSearchController.barchartdatasource) {
    resultSearchController.chartWidget.add(
      MyBarChartWidget(
        dataSource: barChart.dataSource,
        title: barChart.title,
        isString:
            barChart.dataSource.first.y.runtimeType == String ? true : false,
      ),
    );
    resultSearchController.update();
  }
}
