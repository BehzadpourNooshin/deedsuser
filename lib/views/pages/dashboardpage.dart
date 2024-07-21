import 'dart:math';

import 'package:deedsuser/controllers/apicall_controller.dart';
import 'package:deedsuser/controllers/basicdashboard_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/personalsetting_controller.dart';
import 'package:deedsuser/controllers/reportsbycategory_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/models/personalsetting_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/pages/portal.dart';
import 'package:deedsuser/views/widgets/settingspage.dart';
import 'package:deedsuser/views/widgets/summarycard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class DashboardShowPage extends StatelessWidget {
  DashboardShowPage({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    LoginResponseController loginResponseController =
        Get.put(LoginResponseController());

    BasicDashboardInfoController basicDashboardInfoController =
        Get.put(BasicDashboardInfoController());
    if (basicDashboardInfoController.basicDashboardInfo.isEmpty) {
      basicDashboardInfoController.getBasicinfo();
    }
    ErrorhandelingController errorhandelingController =
        Get.put(ErrorhandelingController());
    ResultSearchController resultSearchController =
        Get.put(ResultSearchController());
    OptionSearchController optionSearchController =
        Get.put(OptionSearchController());
    FullReportController fullReportController = Get.put(FullReportController());
    UserController userController = Get.put(UserController());
    APICallController apiCallController = Get.put(APICallController());
    ReportsByCategoryController reportsByCategoryController =
        Get.put(ReportsByCategoryController());
    PersonalSettingController personalSettingController =
        Get.put(PersonalSettingController());
    FilterController formController = Get.put(FilterController());

    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 4 : 2);
    final summaryCardReview = Responsive.isDesktop(context)
        ? 3
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return PortalMasterLayout(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              children: [
                Text(
                  '',
                  style: themeData.textTheme.headlineMedium,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final summaryCardWidth = ((constraints.maxWidth -
                              (kDefaultPadding *
                                  (summaryCardCrossAxisCount - 1))) /
                          summaryCardCrossAxisCount);

                      return Wrap(
                        direction: Axis.horizontal,
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          Obx(
                            () => SummaryCard(
                              title: 'گزارشات',
                              value: basicDashboardInfoController
                                      .basicDashboardInfo.isNotEmpty
                                  ? Text(
                                      basicDashboardInfoController
                                          .basicDashboardInfo[0].numberOfReports
                                          .toString(),
                                      style: CustomTextStyle()
                                          .textStyleDesktopBigTitrKcardColorColor)
                                  : const CircularProgressIndicator(
                                      color: kCardColor),
                              icon: Icons.pie_chart,
                              backgroundColor: kCyanColor,
                              textColor: themeData.colorScheme.onPrimary,
                              iconColor: Colors.black12,
                              width: summaryCardWidth,
                            ),
                          ),
                          Obx(
                            () => SummaryCard(
                              title: 'کاربران',
                              value: basicDashboardInfoController
                                      .basicDashboardInfo.isNotEmpty
                                  ? Text(
                                      basicDashboardInfoController
                                          .basicDashboardInfo[0].numberOfUsers
                                          .toString(),
                                      style: CustomTextStyle()
                                          .textStyleDesktopBigTitrKcardColorColor,
                                    )
                                  : const CircularProgressIndicator(
                                      color: kCardColor),
                              icon: Icons.group_add_rounded,
                              backgroundColor: kLightBlueColor,
                              textColor: themeData.colorScheme.onPrimary,
                              iconColor: Colors.black12,
                              width: summaryCardWidth,
                            ),
                          ),
                          Obx(
                            () => SummaryCard(
                              title: 'کاربران آنلاین',
                              value: basicDashboardInfoController
                                      .basicDashboardInfo.isNotEmpty
                                  ? Text(
                                      basicDashboardInfoController
                                          .basicDashboardInfo[0]
                                          .numberOfOnlineUsers
                                          .toString(),
                                      style: CustomTextStyle()
                                          .textStyleDesktopBigTitrKcardColorColor,
                                    )
                                  : const CircularProgressIndicator(
                                      color: kCardColor),
                              icon: Icons.account_circle_outlined,
                              backgroundColor: kLightGreenColor,
                              textColor: themeData.colorScheme.onPrimary,
                              iconColor: Colors.black12,
                              width: summaryCardWidth,
                            ),
                          ),
                          Obx(
                            () => SummaryCard(
                              title: 'دسته‌بندی گزارشات',
                              value: basicDashboardInfoController
                                      .basicDashboardInfo.isNotEmpty
                                  ? Text(
                                      basicDashboardInfoController
                                          .basicDashboardInfo[0]
                                          .numberOfCategories
                                          .toString(),
                                      style: CustomTextStyle()
                                          .textStyleDesktopBigTitrKcardColorColor,
                                    )
                                  : const CircularProgressIndicator(
                                      color: kCardColor),
                              icon: Icons.category,
                              backgroundColor: kCard1Color,
                              textColor: themeData.colorScheme.onPrimary,
                              iconColor: Colors.black12,
                              width: summaryCardWidth,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(
              () => personalSettingController.dashboardreports.isNotEmpty
                  ? Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: kDefaultPadding),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: (personalSettingController
                                      .dashboardreports.length /
                                  summaryCardReview)
                              .ceil(), // تعداد صفحات
                          itemBuilder: (context, pageIndex) {
                            int startIndex = pageIndex * summaryCardReview;
                            int endIndex = min(
                                startIndex + summaryCardReview,
                                personalSettingController
                                    .dashboardreports.length);

                            // زیرلیست بر اساس startIndex و endIndex ایجاد می‌شود
                            List<Widget> currentPageWidgets = [];
                            for (int i = startIndex; i < endIndex; i++) {
                              currentPageWidgets.add(Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: kPrimaryColor),
                                        top: BorderSide(color: kPrimaryColor)),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25))),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(kDefaultPadding),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors
                                      .click, // Change cursor to click
                                  child: GestureDetector(
                                    onTap: () async {
                                      resultSearchController.datarows.clear();
                                      resultSearchController.headers.clear();
                                      optionSearchController.searchs.clear();
                                      fullReportController.selectedreport
                                          .clear();
                                      fullReportController.update();
                                      apiCallController.isLoading =
                                          !apiCallController.isLoading;
                                      apiCallController.update();
                                      await Network().refreshToken();
                                      await Network()
                                          .getreportbyname(
                                              reportName:
                                                  personalSettingController
                                                      .dashboardreports[i]
                                                      .reportTitle,
                                              accessToken:
                                                  loginResponseController
                                                      .accesstoken.text)
                                          ?.then((value) async {
                                        if (formController.filter.isEmpty) {
                                          errorhandelingController
                                                      .errorTitleMessage
                                                      .value ==
                                                  'خطای نشست'
                                              ? {
                                                  await loginResponseController
                                                      .logout(401)
                                                }
                                              : errorhandelingController
                                                          .errorTitleMessage
                                                          .value ==
                                                      'خطای توکن'
                                                  ? await loginResponseController
                                                      .logout(409)
                                                  : Network.showInternetError(
                                                      context,
                                                      errorhandelingController
                                                          .errorSubTitleMessage
                                                          .value);
                                        }
                                        apiCallController.isLoading =
                                            !apiCallController.isLoading;
                                        apiCallController.update();
                                        Get.toNamed('/reportview');
                                      });
                                    },
                                    child: badges.Badge(
                                      position: badges.BadgePosition.topEnd(
                                          top: -18, end: -15),
                                      showBadge: true,
                                      ignorePointer: false,
                                      badgeContent: IconButton(
                                        tooltip: TablesConstant()
                                            .toolTipDeactiveAccess,
                                        icon: Icon(
                                          Icons.clear_outlined,
                                          size: SideMenuConstant().iconSize,
                                          color: kBlackColor,
                                        ),
                                        onPressed: () async {
                                          personalSettingController
                                              .setaccountreports
                                              .clear();
                                          personalSettingController.update();
                                          personalSettingController
                                              .setaccountreports
                                              .add(PersonalSettingModel(
                                                  userEmail: userController
                                                      .username.text,
                                                  reportTitle:
                                                      personalSettingController
                                                          .dashboardreports[i]
                                                          .reportTitle,
                                                  viewChart:
                                                      personalSettingController
                                                          .dashboardreports[i]
                                                          .viewChart,
                                                  viewInHomePage:
                                                      personalSettingController
                                                          .dashboardreports[i]
                                                          .viewInHomePage,
                                                  active: false));
                                          personalSettingController.update();
                                          showDialogApiCallBefore(context);
                                          await Network().refreshToken();
                                          await Network()
                                              .deletepersoanlsetting(
                                            personalSettingController:
                                                personalSettingController,
                                          )
                                              ?.then((value) async {
                                            apiCallAfter(context);
                                            if (value == false) {
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
                                              personalSettingController
                                                  .setaccountreports
                                                  .clear();
                                              personalSettingController
                                                  .viewInHomePage.text = '';
                                              personalSettingController
                                                  .update();

                                              await Network()
                                                  .getpersonalsetting(
                                                      email: userController
                                                          .username.text,
                                                      accessToken:
                                                          loginResponseController
                                                              .accesstoken.text)
                                                  ?.then((value) async {
                                                if (value == false) {
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
                                                  personalSettingController
                                                      .mergeTwoList(
                                                          reportsByCategoryController,
                                                          personalSettingController);
                                                }
                                              });
                                            }
                                          });
                                        },
                                      ),
                                      badgeAnimation:
                                          const badges.BadgeAnimation.rotation(
                                        animationDuration: Duration(seconds: 1),
                                        colorChangeAnimationDuration:
                                            Duration(seconds: 1),
                                        loopAnimation: false,
                                        curve: Curves.fastOutSlowIn,
                                        colorChangeAnimationCurve:
                                            Curves.easeInCubic,
                                      ),
                                      badgeStyle: badges.BadgeStyle(
                                        borderSide: BorderSide.none,
                                        badgeColor: kCardColor.withOpacity(0.2),
                                        elevation: 0,
                                      ),
                                      child: SummaryCardInfoReport(
                                        value: personalSettingController
                                            .dashboardreports[i]
                                            .reportDisplayTitle
                                            .substring(
                                                0,
                                                min(
                                                    personalSettingController
                                                        .dashboardreports[i]
                                                        .reportDisplayTitle
                                                        .length,
                                                    25)),
                                        backgroundColor: kCardColor,
                                        textColor: kBlackColor,
                                        iconColor: kPrimaryColor,
                                        width: Get.width / 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                            }

                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: currentPageWidgets,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Scaffold(
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.endFloat,
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          final scrollController = ScrollController();
                          showBarModalBottomSheet(
                            context: context,
                            barrierColor: kCardColor.withOpacity(0),
                            expand: false,
                            bounce: true,
                            backgroundColor: kCardColor.withOpacity(0),
                            elevation: 10,
                            useRootNavigator: true,
                            isDismissible: true,
                            enableDrag: true,
                            overlayStyle: const SystemUiOverlayStyle(
                              statusBarColor: Colors.transparent,
                              statusBarIconBrightness: Brightness.dark,
                            ),
                            closeProgressThreshold: 0.3,
                            animationCurve: Curves.easeIn,
                            duration: const Duration(milliseconds: 600),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                            ),
                            builder: (context) => FractionallySizedBox(
                              heightFactor: 1,
                              widthFactor: 0.5,
                              child: SingleChildScrollView(
                                child: PersonalSettingTable(
                                  scrollController: scrollController,
                                ),
                              ),
                            ),
                          );
                        },
                        backgroundColor: kPrimaryColor,
                        tooltip: SideMenuConstant().myfavorite['name'],
                        child: Icon(
                          Icons.settings,
                          color: kCardColor,
                          size: SideMenuConstant().iconSize * 2,
                        ),
                      ),
                      // body: Center(
                      //     child: Text(SideMenuConstant().myfavorite['name'],
                      //         style: Responsive.isDesktop(context)
                      //             ? CustomTextStyle()
                      //                 .textStyleDesktopBigTitrKblackcolor
                      //             : CustomTextStyle()
                      //                 .textStyleTabletkBlackColorTitr)),
                    ),
            ),
          ),
          SizedBox(height: Get.height / 70),
          Obx(
            () => personalSettingController.dashboardreports.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      (personalSettingController.dashboardreports.length /
                              summaryCardReview)
                          .ceil(),
                      (index) => buildDot(index),
                    ),
                  )
                : Container(),
          )
        ],
      ),

      //         child: Container(
      //             padding: EdgeInsets.all(20),
      //             decoration: BoxDecoration(
      //                 border: Border(
      //                     bottom:
      //                         BorderSide(color: kPrimaryColor),
      //                     top: BorderSide(color: kPrimaryColor)),
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(25),
      //                     bottomRight: Radius.circular(25))),
      //             child:
      //     : Expanded(
      //         child: MyPieChartWidget(
      //             dataSource: datasourcepiechart,
      //             title: 'فروش به تفکیک تکنولوژی')),
      // Expanded(
      //     child: MyPieChartWidget(
      //         dataSource: datasourcepiechart,
      //         title: 'فروش به تفکیک تکنولوژی')),
      // Expanded(
      //     child: MyPieChartWidget(
      //         dataSource: datasourcepiechart,
      //         title: 'فروش به تفکیک تکنولوژی')),
    );
  }

  Widget buildDot(int index) {
    return MouseRegion(
        cursor: SystemMouseCursors.click, // Change cursor to click
        child: GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: Container(
              width: Get.width / 100,
              height: Get.height / 60,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: kPrimaryColor),
            ),
          ),
        ));
  }
}
