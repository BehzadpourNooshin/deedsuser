import 'package:deedsuser/models/column_model.dart';

class TableModel {
  TableModel({
    required this.dbTableName,
    required this.fields,
    required this.active,

    // required this.columns,
  });

  late final String dbTableName;
  late final List<ColumnModel> fields;
  late final bool active;

  // late final List<ColumnModel> columns;

  static List<TableModel> listFromJson(dynamic json) {
    return List<TableModel>.from(
        json.map((tables) => TableModel.fromJson(tables)));
  }

  Map<String, dynamic> toJson() {
    return {
      'dbTableName': dbTableName,
      'fields': fields,
      'active': active
      // , 'columns': columns
    };
  }

  factory TableModel.fromJson(dynamic json) {
    return TableModel(
      dbTableName: json['dbTableName'],
      fields: json['fields'],
      active: json['active'],
      //  columns: json['columns']
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
