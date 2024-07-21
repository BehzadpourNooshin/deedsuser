class SettingModel {
  SettingModel({
    required this.hasExcelExport,
    required this.hasPDFExport,
    required this.hasChart,
  });

  late final String hasExcelExport;
  late final String hasPDFExport;
  late final String hasChart;

  static List<SettingModel> listFromJson(dynamic json) {
    return List<SettingModel>.from(
        json.map((setting) => SettingModel.fromJson(setting)));
  }

  Map<String, dynamic> toJson() {
    return {
      'hasExcelExport': hasExcelExport,
      'hasPDFExport': hasPDFExport,
      'hasChart': hasChart,
    };
  }

  factory SettingModel.fromJson(dynamic json) {
    return SettingModel(
      hasExcelExport: json['hasExcelExport'],
      hasPDFExport: json['hasPDFExport'],
      hasChart: json['hasChart'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
