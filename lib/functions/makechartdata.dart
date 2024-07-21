import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/models/charts_model.dart';

makeDataForChart(
  ResultSearchController resultSearchController,
  ChartModel chart,
) {
  List chartHeaders = [];
  List chartValues = [];
  for (var column in resultSearchController.header) {
    for (var chartfield in chart.chartFields) {
      if (column.toString().replaceAll(' ', '') ==
          chartfield.toString().replaceAll(' ', '')) {
        chartHeaders.add(column);
      }
    }
  }
  int i = 0;
  for (var row in resultSearchController.datarows) {
    for (var column in resultSearchController.header) {
      i = 0;
      for (var chartfield in chart.chartFields) {
        if (column.toString().replaceAll(' ', '') ==
            chartfield.toString().replaceAll(' ', '')) {
          chartValues.add(row[i]);
        }
      }
    }
  }
  return {chartValues, chartHeaders};
}
