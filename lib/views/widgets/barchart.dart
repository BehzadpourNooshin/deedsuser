import 'package:deedsuser/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyBarChartData {
  MyBarChartData(
    this.x,
    this.y,
  );
  late String x;
  late double y;
}

class MyBarChartWidget extends StatelessWidget {
  final List<MyBarChartData> dataSource;
  final String title;
  final bool isString;

  const MyBarChartWidget(
      {super.key,
      required this.dataSource,
      required this.title,
      required this.isString});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      enableAxisAnimation: true,
      palette: const [kPrimaryColor, kCardColor, kBlackColor, kCyanColor],
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: const CategoryAxis(
        interval: 1,
        labelIntersectAction: AxisLabelIntersectAction.wrap,
      ),
      title: ChartTitle(text: title),
      series: <CartesianSeries<MyBarChartData, String>>[
        BarSeries<MyBarChartData, String>(
          dataSource: dataSource,
          xValueMapper: (MyBarChartData dataSource, _) => dataSource.x,
          yValueMapper: (MyBarChartData dataSource, _) => dataSource.y,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true, // نمایش مقدار داده‌ها روی بارها
          ),
        )
      ],
    );
  }
}
