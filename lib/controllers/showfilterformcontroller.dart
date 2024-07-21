import 'package:get/get.dart';

class MyFilterFormController extends GetxController {
  var selectedIndex = 0.obs;
  final selectedStartDate = "تاریخ شروع".obs;
  final selectedEndDate = "تاریخ پایان".obs;
  final List<Map<String, dynamic>> filterform = [
    {
      'formItemTitle': 'کد منطقه',
      'formItemType': 'int',
      'formItemInputType': 'DropDown',
      'formItemValidationType': '',
      'formItemInputTypeHint': 'کد منطقه را انتخاب نمایید',
    },
    {
      'formItemTitle': 'میزان مصرف ',
      'formItemType': 'int',
      'formItemInputType': 'TextField',
      'formItemValidationType': '',
      'formItemInputTypeHint': 'میزان مصرف را وارد نمایید',
    },
    {
      'formItemTitle': 'پسورد',
      'formItemType': 'Password',
      'formItemInputType': 'TextField',
      'formItemValidationType': '',
      'formItemInputTypeHint': 'پسورد',
    },
    {
      'formItemTitle': 'تا تاریخ',
      'formItemType': 'DateTime',
      'formItemInputType': 'PickDate',
      'formItemValidationType': '',
      'formItemInputTypeHint': 'تا تاریخ',
    }
  ];
  void setStartDate(int year, int month, int day) {
    selectedStartDate.value =
        '${year.toString()}/${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}';
    update();
  }

  void setEndDate(int year, int month, int day) {
    selectedEndDate.value =
        '${year.toString()}/${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}';
    update();
  }
}
