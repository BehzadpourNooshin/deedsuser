import 'package:deedsuser/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyLineChartData {
  MyLineChartData(this.x, this.y);
  late var x;
  late var y;
}

class MyLineChart extends StatelessWidget {
  final List<MyLineChartData> dataSource;
  final bool isString;
  final String title;
  const MyLineChart(
      {super.key,
      required this.dataSource,
      required this.title,
      required this.isString});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
        ),
        plotAreaBackgroundColor: kCardColor,
        backgroundColor: kCardColor,
        title: ChartTitle(
            text:
                title), //Chart title.          legend: Legend(isVisible: true), // Enables the legend.          tooltipBehavior: ChartTooltipBehavior(enable: true), // Enables the tooltip.

        series: isString
            ? <CartesianSeries>[
                // Initialize line series.
                FastLineSeries<MyLineChartData, String>(
                    xValueMapper: (MyLineChartData dataSource, _) =>
                        dataSource.x,
                    yValueMapper: (MyLineChartData dataSource, _) =>
                        dataSource.y)
              ]
            : <CartesianSeries>[
                // Initialize line series.
                FastLineSeries<MyLineChartData, int>(
                    xValueMapper: (MyLineChartData dataSource, _) =>
                        dataSource.x,
                    yValueMapper: (MyLineChartData dataSource, _) =>
                        dataSource.y)
              ]);
  }
}
