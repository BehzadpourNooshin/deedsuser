class ChartModel {
  ChartModel({
    required this.chartType,
    required this.chartFields,
    required this.active,
  });

  late final String chartType;
  late final List chartFields;
  late final bool active;

  static List<ChartModel> listFromJson(dynamic json) {
    return List<ChartModel>.from(
        json.map((charts) => ChartModel.fromJson(charts)));
  }

  Map<String, dynamic> toJson() {
    return {
      'chartType': chartType,
      'chartFields': chartFields,
      'active': active
    };
  }

  factory ChartModel.fromJson(dynamic json) {
    return ChartModel(
      chartType: json['chartType'],
      chartFields: json['chartFields'],
      active: json['active'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
