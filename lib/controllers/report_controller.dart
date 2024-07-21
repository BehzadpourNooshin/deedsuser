import 'package:deedsuser/models/filters_models.dart';
import 'package:deedsuser/models/reports_model.dart';
import 'package:deedsuser/models/tables_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final reportsLoading = false.obs;
  final fileData = <List<dynamic>>[].obs;
  final searchReports = '-'.obs;
  final reporttitle = TextEditingController();
  final reportdesc = TextEditingController();
  final categorytitle = TextEditingController();
  final categoryid = TextEditingController();
  final tables = <List<TableModel>>[].obs;
  final filters = <List<FilterModel>>[].obs;
  final settings = <List<SettingsModel>>[].obs;

  bool isAdd = false;
  int index = 0;
  RxList<ReportModel> report = <ReportModel>[].obs;

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
