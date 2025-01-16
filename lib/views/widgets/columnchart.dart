import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/constant.dart';

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
      palette: const [kPrimaryColor, kCardColor, kBlackColor, kCyanColor],
      enableAxisAnimation: true,
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: const CategoryAxis(
        interval: 1,
        labelIntersectAction: AxisLabelIntersectAction.wrap,
      ),
      title: ChartTitle(text: title),
      series: <CartesianSeries<MyColumnChartData, String>>[
        ColumnSeries<MyColumnChartData, String>(
          dataSource: dataSource,
          xValueMapper: (MyColumnChartData dataSource, _) => dataSource.x,
          yValueMapper: (MyColumnChartData dataSource, _) => dataSource.y,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true, // نمایش مقدار داده‌ها روی بارها
          ),
        )
      ],
    );
  }
}
