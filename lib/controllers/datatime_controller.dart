import 'package:get/get.dart';

class DateTimeController extends GetxController {
  var selectedStartDate = 'تاریخ شروع'.obs;
  var selectedEndDate = 'تاریخ پایان'.obs;
  var selectedSingleDate = 'تاریخ'.obs;

  void resetDateTime() {
    selectedStartDate.value = 'تاریخ شروع';
    selectedEndDate.value = 'تاریخ پایان';
    selectedSingleDate.value = 'تاریخ';
  }
}
