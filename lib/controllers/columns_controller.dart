import 'package:deedsuser/models/column_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColumnController extends GetxController {
  final searchColumns = '-'.obs;
  final columnTitle = TextEditingController();
  final columnDBFieldName = TextEditingController();
  final hasSortLink = TextEditingController();
  RxList<ColumnModel> columns = <ColumnModel>[].obs;
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
