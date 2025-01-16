import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:get/get.dart';

int findChildLookupIdx(String parentFilterTitle) {
  bool find = false;
  int findIdx = -1;

  FullReportController fullReportController = Get.put(FullReportController());
  for (int i = 0; i < fullReportController.fullreports[0].filters.length; i++) {
    if (fullReportController.fullreports[0].filters[i].parentLookupName
            .toLowerCase()
            .replaceAll(' ', '') ==
        parentFilterTitle.toLowerCase().replaceAll(' ', '')) {
      find = true;
      findIdx = i;
      break;
    }
  }
  find == false ? findIdx = -1 : null;

  return findIdx;
}

String findChildLookupName(int idx) {
  String findLookUpTitle = '';

  FullReportController fullReportController = Get.put(FullReportController());
  findLookUpTitle = fullReportController.fullreports[0].filters[idx].lookupName;

  return findLookUpTitle;
}
