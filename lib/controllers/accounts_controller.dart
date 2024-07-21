import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deedsuser/models/accounts_model.dart';

class AccountsController extends GetxController {
  final accountsLoading = false.obs;
  final fileData = <List<dynamic>>[].obs;
  final searchAccounts = '-'.obs;
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final mobileNumber = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final gender = TextEditingController();
  final role = TextEditingController();
  var firstnameobs = '-'.obs;
  var lastnameobs = '-'.obs;
  var mobileNumberobs = '-'.obs;
  var addressobs = '-'.obs;

  final password = TextEditingController();
  final currentPassword = TextEditingController();
  var currentpassowrdobs = '-'.obs;
  var newPassowrdobs = '-'.obs;
  var confirmNewPasswordobs = '-'.obs;
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();
  RxBool isPasswordMatch = false.obs;
  RxBool changeAccount = false.obs;
  RxBool currentPasswordNotEmpty = false.obs;
  RxBool newPasswordNotEmpty = false.obs;
  RxBool confirmNewPasswordNotEmpty = false.obs;
  void validatePassword() {
    if (newPassowrdobs.value.isNotEmpty &&
        confirmNewPasswordobs.value.isNotEmpty) {
      if (newPassowrdobs.value != confirmNewPasswordobs.value) {
        isPasswordMatch.value = false;
      } else {
        isPasswordMatch.value = true;
      }
    } else {
      isPasswordMatch.value = false;
    }
    update();
  }

  bool isAdd = false;
  int index = 0;
  RxList<AccountModel> account = <AccountModel>[].obs;
  RxList<AccountModel> accountsShow = <AccountModel>[].obs;
  RxList<AccountModel> accountsFiltered = <AccountModel>[].obs;
  RxList<AccountModel> accountsSelected = <AccountModel>[].obs;
  final selectedRole = '-'.obs;
  final selectedGender = '-'.obs;
  final countOfAccounts = 0.obs;
  final countOfAccountsShow = 0.obs;
  final countOfAccountsFiltered = 0.obs;
  final validationPasswordProp = false.obs;
  var uploadFile = false.obs;
  var validationAccountProp = false.obs;
  List accountsrolecontrollerlist = ['USER', 'ADMIN', 'BOTH'];
  List accountsgenfercontrollerlist = ['FEMALE', 'MALE', 'OTHER'];
  void updateCountOfAccounts() {
    countOfAccounts.value = countOfAccounts.value + 1;
    update();
  }

  void compareAccount() {
    account[0].firstname == firstnameobs.value &&
            account[0].lastname == lastnameobs.value &&
            account[0].address == addressobs.value &&
            account[0].mobileNumber == mobileNumberobs.value
        ? changeAccount.value = false
        : changeAccount.value = true;

    update();
  }

  void validationPassword() {
    isPasswordMatch.value == true &&
            currentpassowrdobs.value.isNotEmpty &&
            newPassowrdobs.value.isNotEmpty &&
            confirmNewPasswordobs.value.isNotEmpty
        ? validationPasswordProp.value = true
        : validationPasswordProp.value = false;

    update();
  }

  void validationAccount() {
    compareAccount();
    changeAccount.value == true &&
            firstnameobs.value.isNotEmpty &&
            lastnameobs.value.isNotEmpty &&
            mobileNumberobs.value.isNotEmpty &&
            addressobs.value.isNotEmpty
        ? validationAccountProp.value = true
        : validationAccountProp.value = false;

    update();
  }

  void resetCountOfAccounts() {
    countOfAccounts.value = 0;
    update();
  }

  void updateCountOfAccountsShow() {
    countOfAccountsShow.value = countOfAccountsShow.value + 1;
    update();
  }

  void resetCountOfAccountsShow() {
    countOfAccountsShow.value = 0;
    update();
  }

  void updateCountOfAccountsFiltered() {
    countOfAccountsFiltered.value = countOfAccountsFiltered.value + 1;
    update();
  }

  void resetCountOfAccountsFiltered() {
    countOfAccountsFiltered.value = 0;
    update();
  }
}
