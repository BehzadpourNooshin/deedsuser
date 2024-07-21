import 'package:deedsuser/controllers/cornometer_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/reportsbycategory_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/models/personalsetting_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalSettingController extends GetxController {
  RxList<PersonalSettingModel> personalSettings = <PersonalSettingModel>[].obs;
  RxList<PersonalSettingModel> dashboardreports = <PersonalSettingModel>[].obs;
  final selectedreport = TextEditingController();
  final searchrep = ''.obs;
  final confirm = TextEditingController();
  final viewInHomePage = TextEditingController();

  bool isAdd = false;
  int index = 0;

  RxList<PersonalSettingModel> mergeaccountreports =
      <PersonalSettingModel>[].obs;
  RxList<PersonalSettingModel> initialreports = <PersonalSettingModel>[].obs;
  RxList<PersonalSettingModel> filterreports = <PersonalSettingModel>[].obs;
  RxList<PersonalSettingModel> setaccountreports = <PersonalSettingModel>[].obs;

  @override
  void onInit() {
    // Perform initialization tasks here
    initialReports();
    super.onInit();
  }

  Future<void> loadSettingPages() async {
    LoginResponseController loginResponseController =
        Get.find<LoginResponseController>();
    UserController userController = Get.put(UserController());
    ReportsByCategoryController reportsByCategoryController =
        Get.find<ReportsByCategoryController>();
    PersonalSettingController personalSettingController =
        Get.put(PersonalSettingController());
    ErrorhandelingController errorHandelingController =
        Get.put(ErrorhandelingController());
    CornometerController cornometerController =
        Get.find<CornometerController>();
    cornometerController.loadTimerDuration();
    await loginResponseController.loadAccessToken();
    await userController.loadEmail();
    await loginResponseController.loadIsLoggedIn();
    loginResponseController.update();
    userController.update();
    await Network().refreshToken();

    await Network()
        .allreportbasetcategory(
            accessToken: loginResponseController.accesstokenstorage.value)!
        .then((value) async {
      if (value) {
        await Network()
            .getpersonalsetting(
                email: userController.username.text,
                accessToken: loginResponseController.accesstokenstorage.value)!
            .then((value) {
          if (value) {
            reportsByCategoryController.makeGenerateAllReports();
            mergeTwoList(
                reportsByCategoryController, personalSettingController);
          }
        });
      } else {
        errorHandelingController.errorTitleMessage.value == 'خطای نشست' ||
                errorHandelingController.errorTitleMessage.value == 'خطای توکن'
            ? await loginResponseController.logout(401)
            : null;
      }
    });

    update();
  }

  void makeDashboardWidgtes(
      ReportsByCategoryController reportsByCategoryController,
      PersonalSettingController personalSettingController) {
    UserController userController = Get.put(UserController());

    bool find = false;
    personalSettingController.dashboardreports.clear();
    update();
    for (var report in personalSettingController.personalSettings) {
      find = false;
      for (var report1 in reportsByCategoryController.allreports) {
        if (report.reportTitle == report1.reportName) {
          if (personalSettingController.dashboardreports.isNotEmpty) {
            for (var report2 in personalSettingController.dashboardreports) {
              if (report2.reportTitle == report.reportTitle) {
                find = true;
              }
            }
          }

          if (find == false && report.active == true) {
            personalSettingController.dashboardreports.add(
              PersonalSettingModel(
                userEmail: userController.username.text,
                reportTitle: report1.reportName,
                reportDisplayTitle: report1.displayTitle,
                active: report.active,
                viewChart: report.viewChart,
                viewInHomePage: report.viewInHomePage,
              ),
            );
            update();
          }
          update();
        }
      }
    }

    update();
  }

  void mergeTwoList(ReportsByCategoryController reportsByCategoryController,
      PersonalSettingController personalSettingController) async {
    UserController userController = Get.put(UserController());

    bool findall = false;
    bool find = false;
    personalSettingController.mergeaccountreports.clear();
    personalSettingController.filterreports.clear();
    for (var report in reportsByCategoryController.allreports) {
      findall = false;

      for (var report1 in personalSettingController.personalSettings) {
        if (report.reportName == report1.reportTitle) {
          findall = true;
          find = false;
          if (personalSettingController.filterreports.isEmpty) {
            find = false;
          } else {
            for (var report2 in personalSettingController.filterreports) {
              if (report2.reportTitle == report.reportName) {
                find = true;
              }
            }
          }
          if (find == false && report.active == true) {
            personalSettingController.mergeaccountreports.add(
              PersonalSettingModel(
                userEmail: userController.username.text,
                reportTitle: report1.reportTitle,
                reportDisplayTitle: report.displayTitle,
                active: report1.active,
                viewChart: report1.viewChart,
                viewInHomePage: true,
              ),
            );
            personalSettingController.filterreports.add(
              PersonalSettingModel(
                userEmail: userController.username.text,
                reportTitle: report1.reportTitle,
                reportDisplayTitle: report.displayTitle,
                active: report1.active,
                viewChart: report1.viewChart,
                viewInHomePage: true,
              ),
            );
          }
        }
      }

      if (findall == false) {
        personalSettingController.mergeaccountreports.add(
          PersonalSettingModel(
            userEmail: userController.username.text,
            reportTitle: report.reportName,
            reportDisplayTitle: report.displayTitle,
            active: false,
            viewChart: false,
            viewInHomePage: false,
          ),
        );
        personalSettingController.filterreports.add(
          PersonalSettingModel(
            userEmail: userController.username.text,
            reportTitle: report.reportName,
            reportDisplayTitle: report.displayTitle,
            active: false,
            viewChart: false,
            viewInHomePage: false,
          ),
        );
      }
    }
    update();
  }

  void initialReports() async {
    UserController userController = Get.put(UserController());
    initialreports.clear();
    filterreports.clear();
    final reportsByCategoryController = Get.put(ReportsByCategoryController());
    for (var rep in reportsByCategoryController.allreports) {
      final reportDto = PersonalSettingModel(
        active: false,
        userEmail: userController.username.text,
        reportTitle: rep.reportName,
        reportDisplayTitle: rep.displayTitle,
        viewChart: false,
        viewInHomePage: false,
      );
      initialreports.add(reportDto);
      filterreports.add(reportDto);
    }
    update(); // Update after adding all reports
  }

  Future<void> filterAccountsRep(String query) async {
    UserController userController = Get.put(UserController());
    filterreports.clear();
    searchrep.value = query;

    if (mergeaccountreports.isNotEmpty) {
      for (var rep in mergeaccountreports) {
        if (rep.reportDisplayTitle.contains(searchrep.value)) {
          filterreports.add(rep);
        }
      }
    } else {
      final reportsByCategoryController =
          Get.put(ReportsByCategoryController());
      for (var rep in reportsByCategoryController.allreports) {
        if (rep.displayTitle.contains(searchrep.value)) {
          filterreports.add(
            PersonalSettingModel(
              active: false,
              reportDisplayTitle: rep.displayTitle,
              viewChart: false,
              viewInHomePage: false,
              reportTitle: rep.reportName,
              userEmail: userController.username.text,
            ),
          );
        }
      }
    }

    update(); // Update after filtering reports
  }
}
