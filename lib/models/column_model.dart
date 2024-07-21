class ColumnModel {
  ColumnModel({
    required this.columnTitle,
    required this.columnDBFieldName,
    required this.hasSortLink,
    required this.active,
  });

  late final String columnTitle;
  late final String columnDBFieldName;
  late final String hasSortLink;
  late final bool active;

  static List<ColumnModel> listFromJson(dynamic json) {
    return List<ColumnModel>.from(
        json.map((columns) => ColumnModel.fromJson(columns)));
  }

  Map<String, dynamic> toJson() {
    return {
      'columnTitle': columnTitle,
      'columnDBFieldName': columnDBFieldName,
      'hasSortLink': hasSortLink,
      'active': active
    };
  }

  factory ColumnModel.fromJson(dynamic json) {
    return ColumnModel(
        columnTitle: json['columnTitle'],
        columnDBFieldName: json['columnDBFieldName'],
        hasSortLink: json['hasSortLink'],
        active: json['active']);
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
