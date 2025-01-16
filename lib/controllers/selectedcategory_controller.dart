import 'package:get/get.dart';

class SelectedCategoryController extends GetxController {
  var openCategories = <String>[].obs;

  var selectedReport = ''.obs;

  void toggleCategory(String categoryTitle) {
    if (openCategories.contains(categoryTitle)) {
      openCategories.remove(categoryTitle);
    } else {
      openCategories.add(categoryTitle);
    }
  }

  void selectReport(String reportTitle) {
    selectedReport.value = reportTitle;
  }
}
