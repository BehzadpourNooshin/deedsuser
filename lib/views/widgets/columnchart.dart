import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyColumnChartData {
  MyColumnChartData(
    this.x,
    this.y,
  );
  late String x;
  late double y;
}

class MyColumnChartWidget extends StatelessWidget {
  final List<MyColumnChartData> dataSource;
  final String title;
  final bool isString;
  const MyColumnChartWidget(
      {super.key,
      required this.dataSource,
      required this.title,
      required this.isString});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      enableAxisAnimation: true,
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
      ),
      // plotAreaBackgroundColor: kCardColor,
      // backgroundColor: kCardColor,
      //  borderWidth: 10,
      //  borderColor: kPrimaryColor,
      title: ChartTitle(text: title),
      series: [
        isString
            ? ColumnSeries<MyColumnChartData, String>(
                dataSource: dataSource,
                xValueMapper: (MyColumnChartData dataSource, _) => dataSource.x,
                yValueMapper: (MyColumnChartData dataSource, _) => dataSource.y)
            : ColumnSeries<MyColumnChartData, double>(
                dataSource: dataSource,
                xValueMapper: (MyColumnChartData dataSource, _) =>
                    double.parse(dataSource.x),
                yValueMapper: (MyColumnChartData dataSource, _) => dataSource.y)
      ],
    );
  }
}
