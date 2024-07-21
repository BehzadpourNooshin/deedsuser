import 'package:deedsuser/models/serviceinput_model.dart';
import 'package:deedsuser/models/serviceinputfinal_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceInputController extends GetxController {
  final parameterName = TextEditingController();
  final parameterType = TextEditingController();
  final parameterInputType = TextEditingController();
  final parameterInputValue = TextEditingController();

  RxList<ServiceInputModel> serviceinput = <ServiceInputModel>[].obs;
  RxList<String> parameternames = <String>[].obs;
  RxList<ServiceInputFinalModel> serviceinputfinal =
      <ServiceInputFinalModel>[].obs;
  bool isAdd = false;
  int index = 0;
}
