import 'dart:convert';
import 'package:get/get.dart';

class JsonController extends GetxController {
  final jsonText = ''.obs;
  var clipBoardData = ''.obs;
  var copyIndex = 0.obs;
  RxBool isWaiting = false.obs;
  List headers = [].obs;
  List datarows = [].obs;
  void setJson(String json) {
    jsonText.value = json;
  }

  void setClipboardData(String data, int i) {
    clipBoardData.value = data;
    copyIndex.value = i;
  }

  // final List<Map<String, dynamic>> data = [].obs;
  List<dynamic> get parsedJson {
    return json.decode(jsonText.value);
  }
}
