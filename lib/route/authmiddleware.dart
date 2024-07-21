import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final loginResponseController = Get.find<LoginResponseController>();

    print(loginResponseController.isLoggedIn.value);
    print(loginResponseController.accesstokenstorage.value);
    print(loginResponseController.accesstoken.text);
    if (loginResponseController.accesstoken.text == '') {
      print("hellooooooooooo");
    }
    return null;
  }
}
