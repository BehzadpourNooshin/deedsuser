import 'dart:math';

import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/personalsetting_controller.dart';
import 'package:deedsuser/controllers/reportsbycategory_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/models/personalsetting_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/mytextfilterformfieldwidgetsearchreport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalSettingTable extends GetView<PersonalSettingController> {
  final ScrollController scrollController;
  PersonalSettingTable({super.key, required this.scrollController});
  final PersonalSettingController settingController =
      Get.put(PersonalSettingController());

  final searchVal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    settingController.filterreports.isEmpty
        ? settingController.loadSettingPages()
        : null;

    return Container(
      //padding: EdgeInsets.all(kDefaultPadding),
      decoration: const BoxDecoration(
        color: kScreenBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: const MySearchAppBar(),
          ),
          Obx(
            () => SizedBox(
              height:
                  Get.height * max(1, (controller.filterreports.length / 10)),
              width: double.infinity,
              child: Obx(
                () => Card(
                  color: kCardColor,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(kCardColor),

                    // minWidth: 600,
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "عملیات",
                                textAlign: TextAlign.center,
                                style: Responsive.isDesktop(context)
                                    ? CustomTextStyle()
                                        .textStyleDesktopKprimaryColorTitr
                                    : CustomTextStyle()
                                        .textStyleDesktopKprimaryColorTitr,
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.right,
                                "گزارش",
                                style: Responsive.isDesktop(context)
                                    ? CustomTextStyle()
                                        .textStyleDesktopKprimaryColorTitr
                                    : CustomTextStyle()
                                        .textStyleDesktopKprimaryColorTitr,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    rows: controller.filterreports.isNotEmpty
                        ? myDataRow(context, controller.filterreports)
                        : [],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DataRow> myDataRow(
      BuildContext context, List<PersonalSettingModel> reports) {
    LoginResponseController loginResponseController =
        Get.put(LoginResponseController());
    PersonalSettingController personalSettingController =
        Get.put(PersonalSettingController());
    ReportsByCategoryController reportsByCategoryController =
        Get.put(ReportsByCategoryController());
    // mergeTwoList(reportsByCategoryController, accountReportController);
    UserController userController = Get.put(UserController());
    ErrorhandelingController errorhandelingController =
        Get.put(ErrorhandelingController());
    // accountReportController.accountreports.clear();
    return List.generate(
      reports.length,
      (index) => DataRow(
        cells: [
          DataCell(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Visibility(
              visible: reports[index].active ? true : false,
              child: IconButton(
                  tooltip: TablesConstant().toolTipDeactiveAccess,
                  onPressed: () async {
                    personalSettingController.setaccountreports.clear();
                    personalSettingController.update();
                    personalSettingController.setaccountreports.add(
                        PersonalSettingModel(
                            userEmail: userController.username.text,
                            reportTitle: reports[index].reportTitle,
                            viewChart: reports[index].viewChart,
                            viewInHomePage: reports[index].viewInHomePage,
                            active: false));
                    personalSettingController.update();
                    showDialogApiCallBefore(context);
                    await Network().refreshToken();
                    await Network()
                        .deletepersoanlsetting(
                      personalSettingController: personalSettingController,
                    )
                        ?.then((value) async {
                      apiCallAfter(context);
                      if (value == false) {
                        errorhandelingController.errorTitleMessage.value ==
                                'خطای نشست'
                            ? {await loginResponseController.logout(409)}
                            : errorhandelingController
                                        .errorTitleMessage.value ==
                                    'خطای توکن'
                                ? {await loginResponseController.logout(401)}
                                : Network.showInternetError(
                                    context,
                                    errorhandelingController
                                        .errorSubTitleMessage.value);
                      } else {
                        personalSettingController.setaccountreports.clear();
                        personalSettingController.viewInHomePage.text = '';
                        personalSettingController.update();

                        await Network()
                            .getpersonalsetting(
                                email: userController.username.text,
                                accessToken:
                                    loginResponseController.accesstoken.text)
                            ?.then((value) async {
                          if (value == false) {
                            errorhandelingController.errorTitleMessage.value ==
                                    'خطای نشست'
                                ? {await loginResponseController.logout(409)}
                                : errorhandelingController
                                            .errorTitleMessage.value ==
                                        'خطای توکن'
                                    ? {
                                        await loginResponseController
                                            .logout(401)
                                      }
                                    : Network.showInternetError(
                                        context,
                                        errorhandelingController
                                            .errorSubTitleMessage.value);
                          } else {
                            personalSettingController.mergeTwoList(
                                reportsByCategoryController,
                                personalSettingController);
                          }
                        });
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: kErrorColor,
                  )),
            ),
            Visibility(
              visible: reports[index].active ? false : true,
              child: IconButton(
                  tooltip: TablesConstant().toolTipActiveAccess,
                  onPressed: () async {
                    personalSettingController.setaccountreports.clear();
                    personalSettingController.update();

                    personalSettingController.selectedreport.clear();
                    personalSettingController.update();
                    personalSettingController.selectedreport.text =
                        personalSettingController
                            .filterreports[index].reportTitle;

                    personalSettingController.update();
                    personalSettingController.setaccountreports
                        .add(PersonalSettingModel(
                      userEmail: userController.username.text,
                      active: true,
                      reportTitle: reports[index].reportTitle,
                      viewInHomePage: true,
                      viewChart: true,
                    ));

                    personalSettingController.update();
                    showDialogApiCallBefore(context);
                    await Network().refreshToken();
                    await Network()
                        .setpersonalsettings(
                      personalSettingController: personalSettingController,
                    )
                        ?.then((value) async {
                      apiCallAfter(context);
                      if (value == false) {
                        errorhandelingController.errorTitleMessage.value ==
                                'خطای نشست'
                            ? {await loginResponseController.logout(409)}
                            : errorhandelingController
                                        .errorTitleMessage.value ==
                                    'خطای توکن'
                                ? {await loginResponseController.logout(401)}
                                : Network.showInternetError(
                                    context,
                                    errorhandelingController
                                        .errorSubTitleMessage.value);
                      } else {
                        personalSettingController.setaccountreports.clear();
                        personalSettingController.viewInHomePage.text = '';
                        personalSettingController.update();
                        await Network()
                            .getpersonalsetting(
                                email: userController.username.text,
                                accessToken:
                                    loginResponseController.accesstoken.text)
                            ?.then((value) async {
                          if (value == false) {
                            errorhandelingController.errorTitleMessage.value ==
                                    'خطای نشست'
                                ? {await loginResponseController.logout(409)}
                                : errorhandelingController
                                            .errorTitleMessage.value ==
                                        'خطای توکن'
                                    ? {
                                        await loginResponseController
                                            .logout(401)
                                      }
                                    : Network.showInternetError(
                                        context,
                                        errorhandelingController
                                            .errorSubTitleMessage.value);
                          } else {
                            personalSettingController.mergeTwoList(
                                reportsByCategoryController,
                                personalSettingController);
                          }
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.add, color: kPrimaryColor)),
            ),
          ])),
          DataCell(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              reports[index].reportDisplayTitle,
              style: Responsive.isDesktop(context)
                  ? CustomTextStyle().textStyleDesktopkBlackColor
                  : CustomTextStyle().textStyleDesktopkBlackColor,
            ),
          ])),
        ],
      ),
    );
  }
}

class MySearchAppBar extends GetView<PersonalSettingController> {
  const MySearchAppBar({
    super.key,
  });
  // final AccountsController accountsController = Get.put(AccountsController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: TablesConstant().searchWidth,
          height: TablesConstant().buttonhHeight,
          child: ListTile(
            title: MyTextFormFilterFieldSearchReport(
                directionText: TextDirection.rtl,
                alignment: TextAlign.right,
                labelTitle: 'جستجو',
                hintTitle: 'جستجو'),
          ),
        ),
      ],
    );
  }
}
