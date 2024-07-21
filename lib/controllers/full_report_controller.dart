import 'package:deedsuser/controllers/cornometer_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/models/fullreport_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullReportController extends GetxController {
  RxList<FullReportModel> fullreports = <FullReportModel>[].obs;
  RxList<FullReportModel> selectedreport = <FullReportModel>[].obs;
  var reportname = ''.obs;
  bool isAdd = false;

  Future<void> saveReportName(String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('reportname', newValue);
    reportname.value = newValue;
  }

  Future<void> loadReportName() async {
    LoginResponseController loginResponseController =
        Get.put(LoginResponseController());
    ErrorhandelingController errorhandelingController =
        Get.put(ErrorhandelingController());
    CornometerController cornometerController = Get.put(CornometerController());
    await loginResponseController.loadAccessToken();
    final prefs = await SharedPreferences.getInstance();
    reportname.value = prefs.getString('reportname') ?? '';
    cornometerController.loadTimerDuration();
    await loginResponseController.loadIsLoggedIn();
    loginResponseController.update();
    await Network().refreshToken();
    await Network()
        .getreportbyname(
            reportName: reportname.value.toString(),
            accessToken: loginResponseController.accesstoken.text)
        ?.then((value) async {
      if (value == false) {
        errorhandelingController.errorTitleMessage.value == 'خطای نشست'
            ? await loginResponseController.logout(401)
            : errorhandelingController.errorTitleMessage.value == 'خطای توکن'
                ? await loginResponseController.logout(409)
                : null;
      }
    });
    update();
  }
}
