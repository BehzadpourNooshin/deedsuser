import 'package:deedsuser/models/serviceinput_model.dart';
import 'package:get/get.dart';

class ServiceInputFinalModel {
  ServiceInputFinalModel({
    required this.reportName,
    required this.inputFormInfoFieldsDtoList,

    // required this.columns,
  });

  late final String reportName;
  late final RxList<ServiceInputModel> inputFormInfoFieldsDtoList;
  // late final List<ColumnModel> columns;

  static List<ServiceInputFinalModel> listFromJson(dynamic json) {
    return List<ServiceInputFinalModel>.from(json.map((serviceInputFinal) =>
        ServiceInputFinalModel.fromJson(serviceInputFinal)));
  }

  Map<String, dynamic> toJson() {
    return {
      'reportName': reportName,
      'inputFormInfoFieldsDtoList': inputFormInfoFieldsDtoList,

      // , 'columns': columns
    };
  }

  factory ServiceInputFinalModel.fromJson(dynamic json) {
    return ServiceInputFinalModel(
      inputFormInfoFieldsDtoList: json['inputFormInfoFieldsDtoList'],
      reportName: json['reportName'],
    );
  }
  // ArpuModel.fromJson(Map<String, dynamic> json)
  //     : technology = json['technology'],
  //       rial = json['rial'];
}
