import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyPieChartData {
  MyPieChartData(this.x, this.y);
  late String x;
  late double y;
}

class MyPieChartWidget extends StatelessWidget {
  final List<MyPieChartData> dataSource;
  final String title;
  final bool isString;

  const MyPieChartWidget(
      {super.key,
      required this.dataSource,
      required this.title,
      required this.isString});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        // Enables the tooltip for all the series in chart
        tooltipBehavior: TooltipBehavior(enable: true),
        title: ChartTitle(text: title),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CircularSeries>[
          // Initialize line series
          PieSeries<MyPieChartData, String>(
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              // Enables the tooltip for individual series
              enableTooltip: true,
              dataSource: dataSource,
              xValueMapper: (MyPieChartData dataSource, _) => dataSource.x,
              yValueMapper: (MyPieChartData dataSource, _) => dataSource.y)
        ]);
  }
}
