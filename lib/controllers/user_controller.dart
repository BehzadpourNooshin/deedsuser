import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final username = TextEditingController();
  final role = TextEditingController();
  final password = TextEditingController();
  final accesstoken = TextEditingController();
  final refreshtoken = TextEditingController();
  final expirytoken = 24;
  final firsttimelogin = TextEditingController();
  final expirytime = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    loadEmail();

    //checkLoginStatus('/');
  }

  Future<void> saveEmail(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', newValue);
    username.text = newValue;
    update();
  }

  Future<void> loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    username.text = prefs.getString('email') ?? '';

    update();
  }

  List usercontrollerlist = ['BOTH', 'ADMIN', 'USER'];
}
