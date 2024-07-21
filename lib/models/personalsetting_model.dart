class PersonalSettingModel {
  PersonalSettingModel({
    required this.userEmail,
    required this.reportTitle,
    this.reportDisplayTitle = '',
    required this.viewChart,
    required this.viewInHomePage,
    required this.active,
  });

  late final String userEmail;
  late final String reportTitle;
  final String reportDisplayTitle;
  late final bool viewChart;
  late final bool viewInHomePage;
  late final bool active;
  // late final List<TableModel> table;
  // late final List<FilterModel> filterForm;
  // late final List<SettingsModel> settings;

  static List<PersonalSettingModel> listFromJson(dynamic json) {
    return List<PersonalSettingModel>.from(
        json.map((report) => PersonalSettingModel.fromJson(report)));
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'reportTitle': reportTitle,
      'viewChart': viewChart,
      'viewInHomePage': viewInHomePage,
      'active': active,

      // 'table': table,
      // 'filterForm': filterForm,
      // 'settings': settings,
    };
  }

  factory PersonalSettingModel.fromJson(dynamic json) {
    return PersonalSettingModel(
      userEmail: json['userEmail'],
      reportTitle: json['reportTitle'],
      viewChart: json['viewChart'],
      viewInHomePage: json['viewInHomePage'],
      active: json['active'],
    );
  }
}

class SettingsModel {}
