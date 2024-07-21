import 'package:deedsuser/controllers/user_controller.dart';
import 'package:get/get.dart';

bool isExpiry() {
  UserController userController = Get.find<UserController>();

  final previus = DateTime.parse(userController.firsttimelogin.value.text);

  var diffDt = DateTime.now().difference(previus);
  var diffDM = diffDt.inHours;

  if (diffDM > userController.expirytoken) {
    return true;
  }

  return false;
}
