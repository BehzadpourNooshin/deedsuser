import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:get/get.dart';

bool mathParentLookupWithList(String filterTitle) {
  bool result = false;
  FullReportController fullReportController = Get.find<FullReportController>();
  for (var parentlookup in fullReportController.parentLookups) {
    if (parentlookup.toLowerCase().replaceAll(' ', '') ==
        filterTitle.toLowerCase().replaceAll(' ', '')) {
      result = true;
      break;
    }
  }

  return result;
}
