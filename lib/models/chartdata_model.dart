import 'package:deedsuser/views/widgets/barchart.dart';
import 'package:deedsuser/views/widgets/columnchart.dart';
import 'package:deedsuser/views/widgets/linechart.dart';
import 'package:deedsuser/views/widgets/piechartwidget.dart';

class ColumnChartModel {
  ColumnChartModel({
    required this.dataSource,
    required this.title,
  });

  late final List<MyColumnChartData> dataSource;
  late final String title;
  static List<ColumnChartModel> listFromJson(dynamic json) {
    return List<ColumnChartModel>.from(
        json.map((rows) => ColumnChartModel.fromJson(rows)));
  }

  Map<String, dynamic> toJson() {
    return {
      'dataSource': dataSource,
    };
  }

  factory ColumnChartModel.fromJson(dynamic json) {
    return ColumnChartModel(
      dataSource: json['dataSource'],
      title: json['title'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}

class LineChartModel {
  LineChartModel({
    required this.dataSource,
    required this.title,
  });

  late final List<MyLineChartData> dataSource;
  late final String title;

  static List<LineChartModel> listFromJson(dynamic json) {
    return List<LineChartModel>.from(
        json.map((rows) => LineChartModel.fromJson(rows)));
  }

  Map<String, dynamic> toJson() {
    return {
      'dataSource': dataSource,
    };
  }

  factory LineChartModel.fromJson(dynamic json) {
    return LineChartModel(
      dataSource: json['dataSource'],
      title: json['title'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}

class PieChartModel {
  PieChartModel({
    required this.dataSource,
    required this.title,
  });

  late final List<MyPieChartData> dataSource;
  late final String title;
  late final double groupTo;
  static List<PieChartModel> listFromJson(dynamic json) {
    return List<PieChartModel>.from(
        json.map((rows) => PieChartModel.fromJson(rows)));
  }

  Map<String, dynamic> toJson() {
    return {'dataSource': dataSource};
  }

  factory PieChartModel.fromJson(dynamic json) {
    return PieChartModel(
      dataSource: json['dataSource'],
      title: json['title'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}

class BarChartModel {
  BarChartModel({
    required this.dataSource,
    required this.title,
  });

  late final List<MyBarChartData> dataSource;
  late final String title;
  late final double groupTo;
  static List<BarChartModel> listFromJson(dynamic json) {
    return List<BarChartModel>.from(
        json.map((rows) => BarChartModel.fromJson(rows)));
  }

  Map<String, dynamic> toJson() {
    return {'dataSource': dataSource};
  }

  factory BarChartModel.fromJson(dynamic json) {
    return BarChartModel(
      dataSource: json['dataSource'],
      title: json['title'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
