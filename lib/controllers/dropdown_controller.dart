import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedItems = <String, String>{}.obs;

  void resetDropdowns() {
    selectedItems.clear();
    update();
  }

  void resetDropdown(String dropdownName) {
    selectedItems.clear();
    update();
  }

  void setSelectedItem(String dropdownName, String value) {
    selectedItems[dropdownName] = value;
    update();
  }
}
