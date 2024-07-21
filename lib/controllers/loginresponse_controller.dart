import 'package:deedsuser/controllers/cornometer_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/models/loginresponse_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginResponseController extends GetxController {
  final code = TextEditingController();
  var isLoggedIn = false.obs;
  final accesstoken = TextEditingController();
  var accesstokenstorage = ''.obs;
  final refreshtoken = TextEditingController();
  final resultcallapi = TextEditingController();
  RxList<LoginResponseModel> loginresponse = <LoginResponseModel>[].obs;
  bool isAdd = false;
  int index = 0;
  @override
  void onInit() {
    super.onInit();
    loadAccessToken();
    loadIsLoggedIn();
  }

  Future<void> saveAccessToken(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accesstoken', newValue);

    accesstokenstorage.value = newValue;
  }

  Future<void> saveIsLoggedIn(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', true);
    isLoggedIn.value = true;
  }

  Future<void> loadIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> loadAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    accesstokenstorage.value = prefs.getString('accesstoken') ?? '';
    accesstoken.text = accesstokenstorage.value.toString();
    loginresponse.add(LoginResponseModel(
        code: '',
        accesstoken: accesstoken.text,
        refreshtoken: accesstoken.text));
    update();
    Get.put(UserController()).accesstoken.text =
        accesstokenstorage.value.toString();
    Get.put(UserController()).update();
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    isLoggedIn.value = true;
    Get.offAllNamed('/');
  }

  Future<void> logout(int code) async {
    final usercontroller = Get.put(UserController());
    final cornometerController = Get.put(CornometerController());
    final errorhandelingController = Get.put(ErrorhandelingController());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    cornometerController.resetTimeDuration();
    await prefs.remove('timer_duration');
    await usercontroller.loadEmail();
    isLoggedIn.value = false;

    await Network().logout(email: usercontroller.username.text);

    if (code == 401 || code == 409) {
      Get.snackbar(
        duration: const Duration(seconds: 5),
        errorhandelingController.errorTitleMessage.value,
        errorhandelingController.errorSubTitleMessage.value,
        backgroundColor: kErrorColor.withOpacity(0.7),
        colorText: kCardColor,
      );
    } else if (code == 400) {
      Get.snackbar(
        duration: const Duration(seconds: 5),
        'خطای نشست',
        ErrortHandeling().apiFailureTokenExpiredMessage,
        backgroundColor: kErrorColor.withOpacity(0.7),
        colorText: kCardColor,
      );
    } else if (code == 200) {
      Get.snackbar(
        duration: const Duration(seconds: 5),
        GeneralConstant().snackbarSuccessTitle,
        GeneralConstant().apiCallSuccessUpdateMessage,
        backgroundColor: kSuccessColor.withOpacity(0.7),
        colorText: kCardColor,
      );
    }
    await Get.deleteAll(force: true);

    await Get.offAllNamed('/');
  }

  void lightLogout() {
    final usercontroller = Get.put(UserController());

    usercontroller.loadEmail();

    Network().logout(email: usercontroller.username.text);
    Get.deleteAll(force: true);
    Get.offAllNamed('/');
  }

  Future<void> checkLoginStatus(String permissioroute) async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn.value) {
      Get.offAllNamed(permissioroute);
    } else {
      Get.offAllNamed('/');
    }
  }
}
