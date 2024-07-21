import 'package:deedsuser/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late String errorTextUserName = '.نام کاربری الزامی است';
  late String errorTextPassword = '.رمز عبور الزامی است';
  final username = TextEditingController();
  late bool isLogin = false;
  final role = TextEditingController();
  final password = TextEditingController();
  LoginModel login = LoginModel(email: '', password: '', role: '');
}
