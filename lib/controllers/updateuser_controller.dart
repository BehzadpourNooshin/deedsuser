import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final address = TextEditingController();
  final gender = ['MALE', 'FEMALE', 'OTHER'];
  final mobileNumber = TextEditingController();
  final refreshtoken = TextEditingController();
  final accesstoken = TextEditingController();
}
