import 'package:deedsuser/models/filters_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final searchFilters = '-'.obs;
  final formItemTitle = TextEditingController();
  final formItemType = TextEditingController();
  final formItemInputType = TextEditingController();
  final formItemValidationType = TextEditingController();
  final formItemInputTypeHint = TextEditingController();
  final selectedItem = TextEditingController();
  final isLoading = TextEditingController();

  final List filterValidator = [
    'Not null',
    'Only Digits',
    'Only Characters',
    'Email',
    'Single Line',
  ];
  final List filterDataTypes = [
    'int',
    'double',
    'string',
    'char',
    'bool',
  ];
  final List filterInputType = [
    'Checkbox',
    'Dropdown',
    'RadioButton',
    'Text Input',
  ];
  RxList<FilterModel> filter = <FilterModel>[].obs;
  bool isAdd = false;
  int index = 0;

  // final selectedRole = '-'.obs;
  // final selectedGender = '-'.obs;
  // final countOfAccounts = 0.obs;
  // final countOfAccountsShow = 0.obs;
  // final countOfAccountsFiltered = 0.obs;
  // var uploadFile = false.obs;
  // List accountsrolecontrollerlist = ['USER', 'ADMIN', 'BOTH'];
  // List accountsgenfercontrollerlist = ['FEMALE', 'MALE', 'OTHER'];
  // void updateCountOfAccounts() {
  //   countOfAccounts.value = countOfAccounts.value + 1;
  //   update();
  // }

  // void resetCountOfAccounts() {
  //   countOfAccounts.value = 0;
  //   update();
  // }

  // void updateCountOfAccountsShow() {
  //   countOfAccountsShow.value = countOfAccountsShow.value + 1;
  //   update();
  // }

  // void resetCountOfAccountsShow() {
  //   countOfAccountsShow.value = 0;
  //   update();
  // }

  // void updateCountOfAccountsFiltered() {
  //   countOfAccountsFiltered.value = countOfAccountsFiltered.value + 1;
  //   update();
  // }

  // void resetCountOfAccountsFiltered() {
  //   countOfAccountsFiltered.value = 0;
  //   update();
  // }
}
