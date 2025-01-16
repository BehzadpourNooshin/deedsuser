import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateTimeController extends GetxController {
  var selectedStartDate = 'تاریخ شروع'.obs;
  late Jalali selectedTempStartDate;
  late Jalali selectedTempEndDate;
  var selectedEndDate = 'تاریخ پایان'.obs;
  var selectedStartTime = ''.obs;
  var selectedEndTime = ''.obs;
  var selectedSingleDate = 'تاریخ'.obs;
  var isStartDateEnabled = true.obs; // Added
  var isEndDateEnabled = true.obs; // Added
  var startDateTimestamp = 0.obs;
  var endDateTimestamp = 0.obs;
  var singleDateTimestamp = 0.obs;
  void resetDateTime() {
    selectedStartDate.value = 'تاریخ شروع';
    selectedEndDate.value = 'تاریخ پایان';
    selectedSingleDate.value = 'تاریخ';
  }

  // برای به‌روزرسانی تاریخ و زمان شروع
  void updateStartDate(String date, int timestamp) {
    selectedStartDate.value = date;
    startDateTimestamp.value = timestamp;
  }

  // برای به‌روزرسانی تاریخ و زمان پایان
  void updateEndDate(String date, int timestamp) {
    selectedEndDate.value = date;
    endDateTimestamp.value = timestamp;
  }

  // برای به‌روزرسانی تاریخ و زمان تکی
  void updateSingleDate(String date, int timestamp) {
    selectedSingleDate.value = date;
    singleDateTimestamp.value = timestamp;
  }
}
