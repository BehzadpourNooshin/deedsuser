import 'package:deedsuser/controllers/cornometer_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/models/basicinfo_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:get/get.dart';

class BasicDashboardInfoController extends GetxController {
  RxList<BasicDashboardInfoModel> basicDashboardInfo =
      <BasicDashboardInfoModel>[].obs;

  Future<void> getBasicinfo() async {
    LoginResponseController loginResponseController =
        Get.put(LoginResponseController());
    await loginResponseController.loadAccessToken();
    ErrorhandelingController errorhandelingController =
        Get.put(ErrorhandelingController());
    CornometerController cornometerController = Get.put(CornometerController());
    UserController userController = Get.put(UserController());
    await loginResponseController.loadAccessToken();
    await userController.loadEmail();
    await loginResponseController.loadIsLoggedIn();
    cornometerController.loadTimerDuration();
    loginResponseController.update();
    userController.update();
    await Network().refreshToken();
    await Network()
        .getBasiInfo(accessToken: loginResponseController.accesstoken.text)
        ?.then((value) async {
      if (value) {
        await Network().allreportbasetcategory(
            accessToken: loginResponseController.accesstoken.text);

        await Network().getpersonalsetting(
            email: userController.username.text,
            accessToken: loginResponseController.accesstoken.text);
      } else {
        errorhandelingController.errorTitleMessage.value == 'خطای نشست'
            ? await loginResponseController.logout(401)
            : errorhandelingController.errorTitleMessage.value == 'خطای توکن'
                ? await loginResponseController.logout(409)
                : null;
      }
    });
  }
}

    // if (value == false) {
    //   basicDashboardInfoController.basicDashboardInfo.clear();
    //   basicDashboardInfoController.update();
    //   basicDashboardInfoController.basicDashboardInfo.add(
    //       BasicDashboardInfoModel(
    //           numberOfUsers: 10,
    //           numberOfReports: 12,
    //           numberOfCategories: 13));
    //   basicDashboardInfoController.update();
    // }
 
