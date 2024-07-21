import 'package:deedsuser/models/searchdetail_model.dart';
import 'package:get/get.dart';

class SearchModel {
  SearchModel({
    required this.dbTableName,
    required this.reportName,
    required this.filterFormDtoList,
    required this.pageSize,
    required this.pageNumber,
    required this.sortType,
    required this.sortColumn,
  });

  late final String dbTableName;
  late final String reportName;
  late final List<SearchDetail> filterFormDtoList;
  late final RxInt pageSize;
  late final RxInt pageNumber;
  late final RxString sortType;
  late final RxString sortColumn;

  // late final List<ColumnModel> columns;

  static List<SearchModel> listFromJson(dynamic json) {
    return List<SearchModel>.from(
        json.map((searchs) => SearchModel.fromJson(searchs)));
  }

  Map<String, dynamic> toJson() {
    return {
      'dbTableName': dbTableName,
      'reportName': reportName,
      'filterFormDtoList': filterFormDtoList,
      'sortType': sortType.value,
      'sortColumn': sortColumn.value,
      'pageSize': pageSize.value,
      'pageNumber': pageNumber.value,
      // , 'columns': columns
    };
  }

  factory SearchModel.fromJson(dynamic json) {
    return SearchModel(
      dbTableName: json['dbTableName'],
      reportName: json['reportName'],
      filterFormDtoList: json['filterFormDtoList'],
      sortType: json['sortType'],
      sortColumn: json['sortColumn'],
      pageSize: json['pageSize'],
      pageNumber: json['pageNumber'],

      //  columns: json['columns']
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
