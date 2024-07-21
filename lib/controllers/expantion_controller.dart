import 'package:get/get.dart';

class ExpantionController extends GetxController {
  RxList<String> selectedCategory = <String>[].obs;

  void resetSelectedCategory() {
    selectedCategory.clear();
    update();
  }
}
