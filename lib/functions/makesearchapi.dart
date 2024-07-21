import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/controllers/serviceinputinfo_controller.dart';
import 'package:deedsuser/functions/loaddata.dart';
import 'package:deedsuser/models/serviceinput_model.dart';
import 'package:deedsuser/models/serviceinputfinal_model.dart';
import 'package:get/get.dart';

void makeSearchApi(context) {
  FullReportController fullReportController = Get.put(FullReportController());
  OptionSearchController optionSearchController =
      Get.put(OptionSearchController());
  optionSearchController.searchapi.clear();
  ServiceInputController serviceInputController =
      Get.put(ServiceInputController());
  JsonController jsonController = Get.put(JsonController());

  optionSearchController.searchs.clear();
  ResultSearchController resultSearchController =
      Get.put(ResultSearchController());
  resultSearchController.datarow.clear();
  resultSearchController.header.clear();
  resultSearchController.update();
  optionSearchController.searchDetail.clear();
  optionSearchController.update();
  jsonController.jsonText.value = '';
  jsonController.datarows.clear();
  jsonController.headers.clear();
  jsonController.update();
  for (var filter in fullReportController.selectedreport[0].filters) {
    if (filter.textEditingController.text.isNotEmpty) {
      for (var serviceInput in serviceInputController
          .serviceinputfinal[0].inputFormInfoFieldsDtoList) {
        if (serviceInput.parameterName == filter.formItemTitle) {
          optionSearchController.searchapi.add(ServiceInputModel(
              parameterName: serviceInput.parameterName,
              parameterType: serviceInput.parameterType,
              parameterInputType: serviceInput.parameterInputType,
              parameterValue: filter.textEditingController.text));
          optionSearchController.update();
        }
      }
    }
  }
  optionSearchController.fullsearchapi.clear();
  optionSearchController.update();
  optionSearchController.fullsearchapi.add(ServiceInputFinalModel(
      reportName: fullReportController.selectedreport[0].report.reportName,
      inputFormInfoFieldsDtoList: optionSearchController.searchapi));
  optionSearchController.update();
  jsonController.jsonText.value = '';
  jsonController.headers.clear();
  jsonController.datarows.clear();
  jsonController.update();

  loadData(context);
}
