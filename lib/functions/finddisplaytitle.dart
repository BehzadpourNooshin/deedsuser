import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:get/get.dart';

String findDisplayTitle(String displayTtitle, String groupName) {
  FilterController filterController = Get.find<FilterController>();
  String title = displayTtitle;
  for (var filter in filterController.filter) {
    if (filter.lookupName.toLowerCase().replaceAll(' ', '') ==
        groupName.toLowerCase().replaceAll(' ', '')) {
      for (int i = 0; i < filter.items.length; i++) {
        if (filter.items[i].toLowerCase().replaceAll(' ', '') ==
            displayTtitle.toLowerCase().replaceAll(' ', '')) {
          title = filter.itemsTitle[i];
        }
      }
    }
  }
  return title;
}
