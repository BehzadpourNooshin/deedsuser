import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SideMenusController extends GetxController {
  final isDrawerOpen = false.obs;
  final isEndDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
    update();
  }

  void toggleEndDrawer() {
    isEndDrawerOpen.value = !isEndDrawerOpen.value;
    update();
  }

  void responsiveToggleEndDrawer() {
    isEndDrawerOpen.value = false;
    update();
  }

  void responsiveToggleDrawer() {
    isDrawerOpen.value = false;
    update();
  }
}
