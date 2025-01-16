import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final loginResponseController = Get.find<LoginResponseController>();

    if (loginResponseController.accesstoken.text == '') {}
    return null;
  }
}
