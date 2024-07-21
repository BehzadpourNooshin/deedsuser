import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:get/get.dart';

String findLookupDisplayTitle(String title, String groupName) {
  FilterController filterController = Get.find<FilterController>();
  String displayTitle = title;
  for (var filter in filterController.filter) {
    if (filter.lookupName.toLowerCase().replaceAll(' ', '') ==
        groupName.toLowerCase().replaceAll(' ', '')) {
      for (int i = 0; i < filter.itemsTitle.length; i++) {
        if (filter.itemsTitle[i].toLowerCase().replaceAll(' ', '') ==
            title.toLowerCase().replaceAll(' ', '')) {
          displayTitle = filter.items[i];
        }
      }
    }
  }
  return displayTitle;
}
