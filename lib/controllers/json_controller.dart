import 'dart:convert';
import 'package:get/get.dart';

class JsonController extends GetxController {
  final jsonText = ''.obs;
  RxBool isWaiting = false.obs;
  List headers = [].obs;
  List datarows = [].obs;
  void setJson(String json) {
    jsonText.value = json;
  }

  List<dynamic> get parsedJson {
    return json.decode(jsonText.value);
  }
}
