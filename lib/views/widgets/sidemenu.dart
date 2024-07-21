import 'package:deedsuser/controllers/apicall_controller.dart';
import 'package:deedsuser/controllers/category_controller.dart';
import 'package:deedsuser/controllers/datatime_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/expantion_controller.dart';
import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/menu_controller.dart';
import 'package:deedsuser/controllers/personalsetting_controller.dart';
import 'package:deedsuser/controllers/report_controller.dart';
import 'package:deedsuser/controllers/reportbasecategory_controller.dart';
import 'package:deedsuser/controllers/reportsbycategory_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/controllers/updateuser_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/models/reportbasecategory_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/mysidebartextbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../controllers/offlinemenu_controller.dart';
import '../../controllers/onlinemenu_controller.dart';
import 'mydrawheadersidebar.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('http://deeds.tci.ir/apidoc');

Future<void> _launchUrl() async {
  await launchUrl(_url);
  // if (!await launchUrl(_url)) {
  //   throw Exception('Could not launch $_url');
  // }
}

// ignore: must_be_immutable
class CollapsibleSidebar extends GetView<CategoryController> {
  final SideMenusController sideMenusController =
      Get.put(SideMenusController());
  CollapsibleSidebar({super.key});
  PersonalSettingController personalSettingController =
      Get.put(PersonalSettingController());
  OptionSearchController optionSearchController =
      Get.put(OptionSearchController());
  ResultSearchController resultSearchController =
      Get.put(ResultSearchController());
  MyOnlineReportController myOnlineReportController =
      Get.put(MyOnlineReportController());
  MyOfflineReportsController myOfflineReportsController =
      Get.put(MyOfflineReportsController());
  ReportBaseCategoryController reportBaseCategoryController =
      Get.put(ReportBaseCategoryController());
  JsonController jsonController = Get.put(JsonController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  CategoryController categoryController = Get.put(CategoryController());
  ReportController reportController = Get.put(ReportController());
  UserController userController = Get.put(UserController());
  LoginResponseController loginResponseController =
      Get.put(LoginResponseController());
  ErrorhandelingController errorhandelingController =
      Get.put(ErrorhandelingController());
  ReportsByCategoryController reportsByCategoryController =
      Get.put(ReportsByCategoryController());
  FullReportController fullReportController = Get.put(FullReportController());
  final mainScrollController = ScrollController();
  FilterController formController = Get.put(FilterController());
  final UpdateUserController updateUserController =
      Get.put(UpdateUserController());

  APICallController apiCallController = Get.put(APICallController());
  ExpantionController expantionController = Get.put(ExpantionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
          thumbVisibility: true,
          thickness: SideMenuConstant().scrollbarTickness,
          controller: mainScrollController,
          child: Container(
              decoration: const BoxDecoration(color: kPrimaryColor),
              child: Obx(() => !sideMenusController.isEndDrawerOpen.value &&
                      Responsive.isDesktop(context)
                  ? Drawer(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                      // shape: ShapeBorder.lerp(null, null, 0),
                      backgroundColor: kPrimaryColor,
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          controller: mainScrollController,
                          padding: EdgeInsets.zero,
                          children: [
                            SizedBox(
                              height: SideMenuConstant().heightInternal / 2,
                              child: const MyDrawHeaderSideBar(),
                            ),
                            SideMenuConstant().sizedBoxSideMenu,
                            MyTextButtonSideBar(
                              myicon: Icon(
                                SideMenuConstant().dashboard['icon'],
                                size: SideMenuConstant().iconSize,
                                color: kCardColor,
                              ),
                              name: SideMenuConstant().dashboard['name'],
                              function: () async {
                                jsonController.jsonText.value = '';
                                jsonController.headers.clear();
                                jsonController.datarows.clear();
                                jsonController.update();
                                categoryController.categories.clear();
                                await Network().refreshToken();
                                await Network().getpersonalsetting(
                                    email: userController.username.text,
                                    accessToken: loginResponseController
                                        .accesstoken.text);
                                Get.toNamed('/dashboardscreen');
                              },
                            ),
                            SideMenuConstant().sizedBoxSideMenu,
                            MyTextButtonSideBar(
                                myicon: Icon(
                                  SideMenuConstant().report['icon'],
                                  size: SideMenuConstant().iconSize,
                                  color: kCardColor,
                                ),
                                name: SideMenuConstant().report['name'],
                                function: () async {
                                  reportsByCategoryController
                                          .categoriesLoading.value =
                                      !reportsByCategoryController
                                          .categoriesLoading.value;

                                  reportsByCategoryController.update();
                                  if (reportsByCategoryController
                                      .categoriesLoading.value) {
                                    showDialogApiCallBefore(context);
                                    reportsByCategoryController
                                        .reportsbycategoryshow
                                        .clear();
                                    reportsByCategoryController
                                        .reportsbycategoryshowmarketplace
                                        .clear();
                                    reportsByCategoryController.update();
                                    expantionController.resetSelectedCategory();
                                    dateTimeController.resetDateTime();

                                    dateTimeController.update();

                                    await Network().refreshToken();
                                    await Network()
                                        .allreportbasetcategory(
                                            accessToken: loginResponseController
                                                .accesstoken.text)!
                                        .then((value) async {
                                      if (value == false) {
                                        apiCallAfter(context);
                                        errorhandelingController
                                                    .errorTitleMessage.value ==
                                                'خطای نشست'
                                            ? {
                                                await loginResponseController
                                                    .logout(409)
                                              }
                                            : errorhandelingController
                                                        .errorTitleMessage
                                                        .value ==
                                                    'خطای توکن'
                                                ? {
                                                    await loginResponseController
                                                        .logout(401)
                                                  }
                                                : Network.showInternetError(
                                                    context,
                                                    errorhandelingController
                                                        .errorSubTitleMessage
                                                        .value);
                                      } else {
                                        apiCallAfter(context);
                                        for (var category
                                            in reportsByCategoryController
                                                .reportsbycategory) {
                                          reportsByCategoryController
                                              .reportsbycategoryshow
                                              .add(category);
                                          reportsByCategoryController
                                              .reportsbycategoryshowmarketplace
                                              .add(category);
                                          reportsByCategoryController.update();
                                        }
                                        reportsByCategoryController.update();
                                      }
                                    });
                                  } else {
                                    reportsByCategoryController
                                        .reportsbycategoryshow
                                        .clear();
                                    reportsByCategoryController
                                        .reportsbycategoryshowmarketplace
                                        .clear();
                                    reportsByCategoryController.update();
                                    for (var category
                                        in reportsByCategoryController
                                            .reportsbycategory) {
                                      reportsByCategoryController
                                          .reportsbycategoryshowmarketplace
                                          .add(category);
                                      reportsByCategoryController.update();
                                    }
                                    reportsByCategoryController.update();
                                  }

                                  Get.toNamed('/reportmarketplace');
                                }),
                            for (var item in reportsByCategoryController
                                .reportsbycategoryshow) ...[
                              SingleChildScrollView(
                                child: GestureDetector(
                                  onTap: () {
                                    expantionController.selectedCategory.add(
                                        item.categoryDisplayTitle.toString());
                                    expantionController.update();
                                  },
                                  child: ExpansionTile(
                                    collapsedIconColor: kCardColor,
                                    iconColor: kCardColor,
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          item.categoryDisplayTitle,
                                          style: Responsive.isDesktop(context)
                                              ? CustomTextStyle()
                                                  .textStyleDesktopkCardColor
                                              : CustomTextStyle()
                                                  .textStyleTabletkCardColor,
                                        ),
                                      ],
                                    ),
                                    children: item.reports.map((report) {
                                      return ListTile(
                                        hoverColor: kCardColor.withOpacity(0.2),
                                        tileColor: kPrimaryColor,

                                        title: Text(
                                          textAlign: TextAlign.right,
                                          report.displayTitle,
                                          style: Responsive.isDesktop(context)
                                              ? CustomTextStyle()
                                                  .textStyleDesktopkCardColor
                                              : CustomTextStyle()
                                                  .textStyleTabletkCardColor,
                                        ),
                                        onTap: () async {
                                          jsonController.jsonText.value = '';
                                          jsonController.headers.clear();
                                          jsonController.datarows.clear();
                                          jsonController.update();
                                          resultSearchController.datarows
                                              .clear();
                                          resultSearchController.headers
                                              .clear();
                                          optionSearchController.searchs
                                              .clear();
                                          fullReportController.selectedreport
                                              .clear();

                                          fullReportController.update();

                                          // apiCallController.isLoading = !apiCallController.isLoading;
                                          // apiCallController.update();

                                          TextEditingController controller =
                                              TextEditingController();
                                          controller.text =
                                              report.reportName.toString();
                                          fullReportController
                                              .saveReportName(controller.text);
                                          showDialogApiCallBefore(context);
                                          await Network().refreshToken();
                                          await Network()
                                              .getreportbyname(
                                                  reportName: report.reportName
                                                      .toString(),
                                                  accessToken:
                                                      loginResponseController
                                                          .accesstoken.text)
                                              ?.then((value) async {
                                            if (formController.filter.isEmpty) {
                                              apiCallAfter(context);
                                              errorhandelingController
                                                          .errorTitleMessage
                                                          .value ==
                                                      'خطای نشست'
                                                  ? {
                                                      await loginResponseController
                                                          .logout(409)
                                                    }
                                                  : errorhandelingController
                                                              .errorTitleMessage
                                                              .value ==
                                                          'خطای توکن'
                                                      ? {
                                                          await loginResponseController
                                                              .logout(401)
                                                        }
                                                      : Network.showInternetError(
                                                          context,
                                                          errorhandelingController
                                                              .errorSubTitleMessage
                                                              .value);
                                            } else {
                                              apiCallAfter(context);
                                              fullReportController
                                                  .saveReportName(report
                                                      .reportName
                                                      .toString());
                                              Get.toNamed('/reportview');
                                            }
                                            // apiCallController.isLoading = !apiCallController.isLoading;
                                            // apiCallController.update();
                                          });
                                        },
                                        // updateUserController();
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                            SideMenuConstant().sidemenudivider,
                            SideMenuConstant().sizedBoxSideMenu,
                            MyTextButtonSideBar(
                                myicon: Icon(
                                  Icons.link,
                                  size: SideMenuConstant().iconSize,
                                  color: kCardColor,
                                ),
                                name: 'مشاهده رابط نرم‌افزاری',
                                function: _launchUrl),
                            SideMenuConstant().sizedBoxSideMenu,
                            MyTextButtonSideBar(
                                myicon: Icon(
                                  Icons.settings,
                                  size: SideMenuConstant().iconSize,
                                  color: kCardColor,
                                ),
                                name: SideMenuConstant().myfavorite['name'],
                                function: () async {
                                  showDialogApiCallBefore(context);
                                  await Network().refreshToken();
                                  await Network()
                                      .allreportbasetcategory(
                                          accessToken: loginResponseController
                                              .accesstoken.text)!
                                      .then((value) async {
                                    if (value == false) {
                                      apiCallAfter(context);
                                      errorhandelingController
                                                  .errorTitleMessage.value ==
                                              'خطای نشست'
                                          ? {
                                              await loginResponseController
                                                  .logout(409)
                                            }
                                          : errorhandelingController
                                                      .errorTitleMessage
                                                      .value ==
                                                  'خطای توکن'
                                              ? {
                                                  await loginResponseController
                                                      .logout(401)
                                                }
                                              : Network.showInternetError(
                                                  context,
                                                  errorhandelingController
                                                      .errorSubTitleMessage
                                                      .value);
                                    } else {
                                      await Network()
                                          .getpersonalsetting(
                                              email:
                                                  userController.username.text,
                                              accessToken:
                                                  loginResponseController
                                                      .accesstoken.text)!
                                          .then((value) async {
                                        if (value == false) {
                                          apiCallAfter(context);
                                          errorhandelingController
                                                      .errorTitleMessage
                                                      .value ==
                                                  'خطای نشست'
                                              ? {
                                                  await loginResponseController
                                                      .logout(409)
                                                }
                                              : errorhandelingController
                                                          .errorTitleMessage
                                                          .value ==
                                                      'خطای توکن'
                                                  ? {
                                                      await loginResponseController
                                                          .logout(401)
                                                    }
                                                  : Network.showInternetError(
                                                      context,
                                                      errorhandelingController
                                                          .errorSubTitleMessage
                                                          .value);
                                        } else {
                                          reportsByCategoryController
                                              .makeGenerateAllReports();
                                          personalSettingController
                                              .mergeTwoList(
                                                  reportsByCategoryController,
                                                  personalSettingController);
                                          // ignore: use_build_context_synchronously
                                          apiCallAfter(context);
                                          Get.toNamed('/favortiereport');
                                        }
                                      });
                                    }
                                  });
                                }),
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sidemenudivider,
                            IconButton(
                              onPressed: () {
                                sideMenusController.toggleEndDrawer();
                              },
                              icon: SideMenuConstant().closeSideMenu,
                              color: kCardColor,
                              iconSize: SideMenuConstant().iconSize,
                            ),
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            SideMenuConstant().sizedBoxSideMenu,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'نسخه 0.1',
                                  style: Responsive.isDesktop(context)
                                      ? CustomTextStyle()
                                          .textStyleDesktopkCardColorSideMenu
                                      : CustomTextStyle()
                                          .textStyleTabletkCardColorSideMenu,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ]))
                  : Drawer(
                      // shape: ShapeBorder.lerp(null, null, 0),
                      backgroundColor: kPrimaryColor,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: mainScrollController,
                        padding: EdgeInsets.zero,
                        children: [
                          IconButton(
                              hoverColor: kCardColor.withOpacity(0.2),
                              onPressed: () {
                                categoryController.categories.clear();
                                Get.toNamed('/dashboardscreen');
                              },
                              icon: Icon(
                                SideMenuConstant().dashboard['icon'],
                                color: kCardColor,
                                size: SideMenuConstant().iconSize,
                              )),
                          SideMenuConstant().sizedBoxSideMenu,
                          IconButton(
                              hoverColor: kCardColor.withOpacity(0.2),
                              icon: Icon(
                                SideMenuConstant().report['icon'],
                                color: kCardColor,
                                size: SideMenuConstant().iconSize,
                              ),
                              onPressed: () async {
                                reportsByCategoryController
                                        .categoriesLoading.value =
                                    !reportsByCategoryController
                                        .categoriesLoading.value;

                                reportsByCategoryController.update();
                                if (reportsByCategoryController
                                    .categoriesLoading.value) {
                                  showDialogApiCallBefore(context);
                                  reportsByCategoryController
                                      .reportsbycategoryshow
                                      .clear();
                                  reportsByCategoryController
                                      .reportsbycategoryshowmarketplace
                                      .clear();
                                  reportsByCategoryController.update();
                                  expantionController.resetSelectedCategory();
                                  dateTimeController.resetDateTime();

                                  dateTimeController.update();

                                  await Network().refreshToken();
                                  await Network()
                                      .allreportbasetcategory(
                                          accessToken: loginResponseController
                                              .accesstoken.text)!
                                      .then((value) async {
                                    if (value == false) {
                                      apiCallAfter(context);
                                      errorhandelingController
                                                  .errorTitleMessage.value ==
                                              'خطای نشست'
                                          ? {
                                              await loginResponseController
                                                  .logout(409)
                                            }
                                          : errorhandelingController
                                                      .errorTitleMessage
                                                      .value ==
                                                  'خطای توکن'
                                              ? {
                                                  await loginResponseController
                                                      .logout(401)
                                                }
                                              : Network.showInternetError(
                                                  context,
                                                  errorhandelingController
                                                      .errorSubTitleMessage
                                                      .value);
                                    } else {
                                      apiCallAfter(context);
                                      for (var category
                                          in reportsByCategoryController
                                              .reportsbycategory) {
                                        reportsByCategoryController
                                            .reportsbycategoryshow
                                            .add(category);
                                        reportsByCategoryController
                                            .reportsbycategoryshowmarketplace
                                            .add(category);
                                        reportsByCategoryController.update();
                                      }
                                      reportsByCategoryController.update();
                                    }
                                  });
                                } else {
                                  reportsByCategoryController
                                      .reportsbycategoryshow
                                      .clear();
                                  reportsByCategoryController
                                      .reportsbycategoryshowmarketplace
                                      .clear();
                                  reportsByCategoryController.update();
                                  for (var category
                                      in reportsByCategoryController
                                          .reportsbycategory) {
                                    reportsByCategoryController
                                        .reportsbycategoryshowmarketplace
                                        .add(category);
                                    reportsByCategoryController.update();
                                  }
                                  reportsByCategoryController.update();
                                }

                                Get.toNamed('/reportmarketplace');
                              }),
                          SideMenuConstant().sidemenudivider,
                          SideMenuConstant().sizedBoxSideMenu,
                          IconButton(
                              hoverColor: kCardColor.withOpacity(0.2),
                              icon: Icon(
                                Icons.link,
                                size: SideMenuConstant().iconSize,
                                color: kCardColor,
                              ),
                              onPressed: _launchUrl),
                          SideMenuConstant().sizedBoxSideMenu,
                          IconButton(
                              hoverColor: kCardColor.withOpacity(0.2),
                              icon: Icon(
                                Icons.settings,
                                size: SideMenuConstant().iconSize,
                                color: kCardColor,
                              ),
                              onPressed: () {
                                reportsByCategoryController
                                    .makeGenerateAllReports();
                                Get.toNamed('/favortiereport');
                              }),
                          SideMenuConstant().sidemenudivider,
                          SideMenuConstant().sizedBoxSideMenu,
                          IconButton(
                            hoverColor: kCardColor.withOpacity(0.2),
                            onPressed: () {
                              sideMenusController.toggleEndDrawer();
                            },
                            icon: SideMenuConstant().openSideMenu,
                            color: kCardColor,
                            iconSize: SideMenuConstant().iconSize,
                          ),
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          SideMenuConstant().sizedBoxSideMenu,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'نسخه 0.1',
                                style: Responsive.isDesktop(context)
                                    ? CustomTextStyle()
                                        .textStyleDesktopkCardColorSideMenu
                                    : CustomTextStyle()
                                        .textStyleTabletkCardColorSideMenu,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )))),
    );
  }

  buildReports(var item, ReportController reportController) {
    ReportBaseCategoryController().reportbasecategory.clear();
    for (var repitem in reportController.report) {
      if (repitem.categoryid == item.categoryId) {
        reportBaseCategoryController.reportbasecategory
            .add(ReportBaseCategoryModel(
          reporttitle: repitem.reporttitle,
          reportdesc: repitem.reportdesc,
          categoryid: repitem.categoryid,
          categorytitle: repitem.categorytitle,
          hasExcelExport: repitem.hasExcelExport,
          hasPDFExport: repitem.hasPDFExport,
          hasChart: repitem.hasChart,
        ));
      }
    }

    ReportBaseCategoryController().update();
  }

  List idFromTitle(categories) {
    List<dynamic> items = [];

    for (var item in categories) {
      items.add(item['categoryTitle']);
    }
    return items;
  }
}
