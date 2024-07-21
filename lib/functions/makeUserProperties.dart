import 'package:deedsuser/controllers/user_controller.dart';

void makeUserProperties(UserController userController) {
  userController.firsttimelogin.clear();
  userController.expirytime.clear();
  userController.firsttimelogin.text = DateTime.now().toString();

  var temp =
      DateTime.now().add(Duration(minutes: userController.expirytoken.toInt()));

  userController.expirytime.text = temp.toString();

  userController.update();
}
