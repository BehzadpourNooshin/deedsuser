import 'package:deedsuser/controllers/accounts_controller.dart';
import 'package:deedsuser/controllers/basicdashboard_controller.dart';
import 'package:deedsuser/controllers/cornometer_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/menu_controller.dart';
import 'package:deedsuser/controllers/updatenote_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/endsidemenu.dart';
import 'package:deedsuser/views/widgets/myportaltextbutton.dart';
import 'package:deedsuser/views/widgets/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:badges/badges.dart' as badges;
import 'package:slide_countdown/slide_countdown.dart';

// ignore: must_be_immutable
class PortalMasterLayout extends StatelessWidget {
  final Widget body;
  SideMenusController sideMenuController = Get.put(SideMenusController());
  PortalMasterLayout({
    super.key,
    required this.body,
  });
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    LoginResponseController loginResponseController =
        Get.put(LoginResponseController());
    CornometerController cornometerController = Get.put(CornometerController());
    BasicDashboardInfoController basicInfoDashboardController =
        Get.put(BasicDashboardInfoController());

    UpdateNoteController updateNoteController = Get.put(UpdateNoteController());
    if (!Responsive.isDesktop(context)) {
      sideMenuController.responsiveToggleEndDrawer();
      sideMenuController.responsiveToggleDrawer();
    }
    Get.currentRoute != '/'
        ? html.window.onBeforeUnload.listen((html.Event event) {
            event.preventDefault();
            FlutterWindowClose.setWebReturnValue('خروج');

            loginResponseController.lightLogout();
          })
        : null;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.currentRoute != '/' ? showExitConfirmationDialog(context) : null;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: kCardColor),
          backgroundColor: kPrimaryColor,
          title: Obx(() => sideMenuController.isEndDrawerOpen.value
              ? AnimatedContainer(
                  duration:
                      Duration(milliseconds: MainPageConstant().headerDuration),
                  curve: Curves.easeIn,
                  width: !sideMenuController.isEndDrawerOpen.value
                      ? Get.width
                      : Get.width,
                  child: Responsive.isDesktop(context)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(() => basicInfoDashboardController
                                            .basicDashboardInfo[0]
                                            .numberOfUpdateNotes >
                                        0
                                    ? badges.Badge(
                                        position: badges.BadgePosition.topEnd(
                                            top: 0, end: 3),
                                        showBadge: true,
                                        ignorePointer: false,
                                        onTap: () async {
                                          showDialogApiCallBefore(context);
                                          await Network().refreshToken();
                                          await Network()
                                              .getUpdateNotes(
                                                  accessToken:
                                                      loginResponseController
                                                          .accesstoken.text)
                                              ?.then((value) {
                                            if (value == false) {
                                              apiCallAfter(context);
                                              Network.showInternetError(
                                                  context,
                                                  GeneralConstant()
                                                      .apiCallFailureMessage);
                                            } else {
                                              apiCallAfter(context);

                                              showDialogNotes(
                                                  context,
                                                  basicInfoDashboardController
                                                      .basicDashboardInfo[0]
                                                      .numberOfUpdateNotes);
                                            }
                                          });
                                        },
                                        badgeContent: Text(
                                          basicInfoDashboardController
                                              .basicDashboardInfo[0]
                                              .numberOfUpdateNotes
                                              .toString(),
                                          style: CustomTextStyle()
                                              .textStyleMobileCourierkCardColor,
                                        ),
                                        badgeAnimation: const badges
                                            .BadgeAnimation.rotation(
                                          animationDuration:
                                              Duration(seconds: 1),
                                          colorChangeAnimationDuration:
                                              Duration(seconds: 1),
                                          loopAnimation: false,
                                          curve: Curves.fastOutSlowIn,
                                          colorChangeAnimationCurve:
                                              Curves.easeInCubic,
                                        ),
                                        badgeStyle: badges.BadgeStyle(
                                          shape: badges.BadgeShape.circle,
                                          badgeColor: kErrorColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          elevation: 0,
                                        ),
                                        child: IconButton(
                                          tooltip: NoteConstant().notification,
                                          icon: Icon(Icons.notifications_active,
                                              size:
                                                  SideMenuConstant().iconSize +
                                                      5),
                                          onPressed: () async {
                                            showDialogApiCallBefore(context);
                                            await Network().refreshToken();
                                            await Network()
                                                .getUpdateNotes(
                                                    accessToken:
                                                        loginResponseController
                                                            .accesstoken.text)
                                                ?.then((value) {
                                              if (value == false) {
                                                apiCallAfter(context);
                                                Network.showInternetError(
                                                    context,
                                                    GeneralConstant()
                                                        .apiCallFailureMessage);
                                              } else {
                                                apiCallAfter(context);

                                                showDialogNotes(
                                                    context,
                                                    basicInfoDashboardController
                                                        .basicDashboardInfo[0]
                                                        .numberOfUpdateNotes);
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    : IconButton(
                                        tooltip: NoteConstant().notification,
                                        icon: Icon(Icons.notifications,
                                            size: SideMenuConstant().iconSize +
                                                5),
                                        onPressed: () async {
                                          showDialogApiCallBefore(context);
                                          await Network().refreshToken();
                                          await Network()
                                              .getUpdateNotes(
                                                  accessToken:
                                                      loginResponseController
                                                          .accesstoken.text)
                                              ?.then((value) {
                                            if (value == false) {
                                              apiCallAfter(context);
                                              Network.showInternetError(
                                                  context,
                                                  GeneralConstant()
                                                      .apiCallFailureMessage);
                                            } else {
                                              apiCallAfter(context);

                                              showDialogNotes(context, 0);
                                            }
                                          });
                                        },
                                      )),
                                PopupMenuButton(
                                  tooltip: SideMenuConstant().accountproperties,
                                  popUpAnimationStyle:
                                      AnimationStyle.noAnimation,
                                  color: kPrimaryColor,
                                  icon: Icon(
                                    Icons.account_circle_rounded,
                                    color: kCardColor,
                                    size: SideMenuConstant().iconSize + 10,
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem(
                                          value: 'account',
                                          child: SizedBox(
                                            width: ResponsiveSizedBox()
                                                .middleDistancePopupWidgetwidth,
                                            child: MyTextButtonPoratl(
                                                myicon: Icon(
                                                  SideMenuConstant()
                                                      .account['icon'],
                                                  size: SideMenuConstant()
                                                      .iconSize,
                                                  color: kCardColor,
                                                ),
                                                name: SideMenuConstant()
                                                    .account['name'],
                                                function: () async {
                                                  AccountsController
                                                      accountController =
                                                      Get.put(
                                                          AccountsController());

                                                  accountController.account
                                                      .clear();
                                                  accountController.update();
                                                  showDialogApiCallBefore(
                                                      context);
                                                  await Network()
                                                      .refreshToken();
                                                  await Network()
                                                      .getUser(
                                                          userController:
                                                              userController,
                                                          email: userController
                                                              .username.text)
                                                      .then((value) {
                                                    if (value == false) {
                                                      apiCallAfter(context);
                                                      Network.showInternetError(
                                                          context,
                                                          GeneralConstant()
                                                              .apiCallFailureMessage);
                                                    } else {
                                                      apiCallAfter(context);

                                                      showDialogAccount(
                                                          context);
                                                    }
                                                  });
                                                }),
                                          )),
                                      PopupMenuItem(
                                          value: 'changepassword',
                                          child: SizedBox(
                                              width: ResponsiveSizedBox()
                                                  .middleDistancePopupWidgetwidth,
                                              child: MyTextButtonPoratl(
                                                myicon: Icon(
                                                  Icons.lock_open,
                                                  size: SideMenuConstant()
                                                      .iconSize,
                                                  color: kCardColor,
                                                ),
                                                name: SideMenuConstant()
                                                    .changePassword['name'],
                                                function: () {
                                                  showDialogChangePasword(
                                                      context);
                                                },
                                              ))),
                                      PopupMenuItem(
                                        value: 'exit',
                                        child: SizedBox(
                                          width: ResponsiveSizedBox()
                                              .middleDistancePopupWidgetwidth,
                                          child: MyTextButtonPoratl(
                                            myicon: Icon(
                                              SideMenuConstant().exit['icon'],
                                              size: SideMenuConstant().iconSize,
                                              color: kCardColor,
                                            ),
                                            name:
                                                SideMenuConstant().exit['name'],
                                            function: () async {
                                              loginResponseController.logout(0);
                                            },
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                                Obx(
                                  () => Padding(
                                    padding: EdgeInsets.only(
                                        left: kDefaultPadding / 2),
                                    child: SlideCountdown(
                                      decoration: const BoxDecoration(
                                          color: kPrimaryColor,
                                          border: Border(
                                              bottom:
                                                  BorderSide(color: kCardColor),
                                              top: BorderSide(
                                                  color: kCardColor)),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle()
                                              .textStyleDesktopkCardColor
                                          : CustomTextStyle()
                                              .textStyleTabletkCardColor,
                                      onDone: () {
                                        loginResponseController.logout(400);
                                      },
                                      duration: cornometerController
                                          .timerDuration.value,
                                      durationTitle: DurationTitle.id(),
                                      icon: const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          weight: 0.01,
                                          grade: 1,
                                          applyTextScaling: false,
                                          Icons.alarm,
                                          color: kCardColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(HeaderConstantText().subtitle,
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle()
                                              .textStyleDesktopBigTitrKcardColorColor
                                          : CustomTextStyle()
                                              .textStyleTabletkCardColorTitr),
                                  Text(' - ',
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle()
                                              .textStyleDesktopBigTitrKcardColorColor
                                          : CustomTextStyle()
                                              .textStyleTabletkCardColorTitr),
                                  Text(HeaderConstantText().title,
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle()
                                              .textStyleDesktopBigTitrKcardColorColor
                                          : CustomTextStyle()
                                              .textStyleTabletkCardColorTitr),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: ResponsivePadding()
                                            .largePaddingWidth,
                                        top: ResponsivePadding()
                                            .largePaddingWidth),
                                    child: Image.asset(
                                      color: kCardColor,
                                      HeaderConstantText().logoPath,
                                    ),
                                  ),
                                ])
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() => basicInfoDashboardController
                                            .basicDashboardInfo[0]
                                            .numberOfUpdateNotes >
                                        0
                                    ? badges.Badge(
                                        position: badges.BadgePosition.topEnd(
                                            top: 0, end: 3),
                                        showBadge: true,
                                        ignorePointer: false,
                                        onTap: () async {
                                          showDialogApiCallBefore(context);
                                          await Network().refreshToken();
                                          await Network()
                                              .getUpdateNotes(
                                                  accessToken:
                                                      loginResponseController
                                                          .accesstoken.text)
                                              ?.then((value) {
                                            if (value == false) {
                                              apiCallAfter(context);
                                              Network.showInternetError(
                                                  context,
                                                  GeneralConstant()
                                                      .apiCallFailureMessage);
                                            } else {
                                              apiCallAfter(context);

                                              showDialogNotes(
                                                  context,
                                                  basicInfoDashboardController
                                                      .basicDashboardInfo[0]
                                                      .numberOfUpdateNotes);
                                            }
                                          });
                                        },
                                        badgeContent: Text(
                                          basicInfoDashboardController
                                              .basicDashboardInfo[0]
                                              .numberOfUpdateNotes
                                              .toString(),
                                          style: CustomTextStyle()
                                              .textStyleMobileCourierkCardColor,
                                        ),
                                        badgeAnimation: const badges
                                            .BadgeAnimation.rotation(
                                          animationDuration:
                                              Duration(seconds: 1),
                                          colorChangeAnimationDuration:
                                              Duration(seconds: 1),
                                          loopAnimation: false,
                                          curve: Curves.fastOutSlowIn,
                                          colorChangeAnimationCurve:
                                              Curves.easeInCubic,
                                        ),
                                        badgeStyle: badges.BadgeStyle(
                                          shape: badges.BadgeShape.circle,
                                          badgeColor: kErrorColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          elevation: 0,
                                        ),
                                        child: IconButton(
                                          tooltip: NoteConstant().notification,
                                          icon: Icon(Icons.notifications_active,
                                              size:
                                                  SideMenuConstant().iconSize +
                                                      5),
                                          onPressed: () async {
                                            showDialogApiCallBefore(context);
                                            await Network().refreshToken();
                                            await Network()
                                                .getUpdateNotes(
                                                    accessToken:
                                                        loginResponseController
                                                            .accesstoken.text)
                                                ?.then((value) {
                                              if (value == false) {
                                                apiCallAfter(context);
                                                Network.showInternetError(
                                                    context,
                                                    GeneralConstant()
                                                        .apiCallFailureMessage);
                                              } else {
                                                apiCallAfter(context);

                                                showDialogNotes(
                                                    context,
                                                    basicInfoDashboardController
                                                        .basicDashboardInfo[0]
                                                        .numberOfUpdateNotes);
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    : IconButton(
                                        tooltip: NoteConstant().notification,
                                        icon: Icon(Icons.notifications,
                                            size: SideMenuConstant().iconSize +
                                                5),
                                        onPressed: () async {
                                          showDialogApiCallBefore(context);
                                          await Network().refreshToken();
                                          await Network()
                                              .getUpdateNotes(
                                                  accessToken:
                                                      loginResponseController
                                                          .accesstoken.text)
                                              ?.then((value) {
                                            if (value == false) {
                                              apiCallAfter(context);
                                              Network.showInternetError(
                                                  context,
                                                  GeneralConstant()
                                                      .apiCallFailureMessage);
                                            } else {
                                              apiCallAfter(context);

                                              showDialogNotes(context, 0);
                                            }
                                          });
                                        },
                                      )),
                                PopupMenuButton(
                                  tooltip: SideMenuConstant().accountproperties,
                                  popUpAnimationStyle:
                                      AnimationStyle.noAnimation,
                                  color: kPrimaryColor,
                                  icon: Icon(
                                    Icons.account_circle_rounded,
                                    color: kCardColor,
                                    size: SideMenuConstant().iconSize + 10,
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem(
                                          value: 'account',
                                          child: SizedBox(
                                            width: ResponsiveSizedBox()
                                                .middleDistancePopupWidgetwidth,
                                            child: MyTextButtonPoratl(
                                                myicon: Icon(
                                                  SideMenuConstant()
                                                      .account['icon'],
                                                  size: SideMenuConstant()
                                                      .iconSize,
                                                  color: kCardColor,
                                                ),
                                                name: SideMenuConstant()
                                                    .account['name'],
                                                function: () async {
                                                  AccountsController
                                                      accountController =
                                                      Get.put(
                                                          AccountsController());

                                                  accountController.account
                                                      .clear();
                                                  accountController.update();
                                                  showDialogApiCallBefore(
                                                      context);
                                                  await Network()
                                                      .refreshToken();
                                                  await Network()
                                                      .getUser(
                                                          userController:
                                                              userController,
                                                          email: userController
                                                              .username.text)
                                                      .then((value) {
                                                    if (value == false) {
                                                      apiCallAfter(context);
                                                      Network.showInternetError(
                                                          context,
                                                          GeneralConstant()
                                                              .apiCallFailureMessage);
                                                    } else {
                                                      apiCallAfter(context);

                                                      showDialogAccount(
                                                          context);
                                                    }
                                                  });
                                                }),
                                          )),
                                      PopupMenuItem(
                                          value: 'changepassword',
                                          child: SizedBox(
                                              width: ResponsiveSizedBox()
                                                  .middleDistancePopupWidgetwidth,
                                              child: MyTextButtonPoratl(
                                                myicon: Icon(
                                                  Icons.lock_open,
                                                  size: SideMenuConstant()
                                                      .iconSize,
                                                  color: kCardColor,
                                                ),
                                                name: SideMenuConstant()
                                                    .changePassword['name'],
                                                function: () {
                                                  showDialogChangePasword(
                                                      context);
                                                },
                                              ))),
                                      PopupMenuItem(
                                        value: 'exit',
                                        child: SizedBox(
                                          width: ResponsiveSizedBox()
                                              .middleDistancePopupWidgetwidth,
                                          child: MyTextButtonPoratl(
                                            myicon: Icon(
                                              SideMenuConstant().exit['icon'],
                                              size: SideMenuConstant().iconSize,
                                              color: kCardColor,
                                            ),
                                            name:
                                                SideMenuConstant().exit['name'],
                                            function: () async {
                                              loginResponseController.logout(0);
                                            },
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                                Obx(
                                  () => Padding(
                                    padding: EdgeInsets.only(
                                        left: kDefaultPadding / 2),
                                    child: SlideCountdown(
                                      decoration: const BoxDecoration(
                                          color: kPrimaryColor,
                                          border: Border(
                                              bottom:
                                                  BorderSide(color: kCardColor),
                                              top: BorderSide(
                                                  color: kCardColor)),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle()
                                              .textStyleDesktopkCardColor
                                          : CustomTextStyle()
                                              .textStyleTabletkCardColor,
                                      onDone: () {
                                        loginResponseController.logout(400);
                                      },
                                      duration: cornometerController
                                          .timerDuration.value,
                                      durationTitle: DurationTitle.id(),
                                      icon: const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          weight: 0.01,
                                          grade: 1,
                                          applyTextScaling: false,
                                          Icons.alarm,
                                          color: kCardColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(HeaderConstantText().subtitle,
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle()
                                              .textStyleDesktopBigTitrKcardColorColor
                                          : CustomTextStyle()
                                              .textStyleTabletkCardColorTitr),
                                  Text(' - ',
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle()
                                              .textStyleDesktopBigTitrKcardColorColor
                                          : CustomTextStyle()
                                              .textStyleTabletkCardColorTitr),
                                  Text(HeaderConstantText().title,
                                      style: Responsive.isDesktop(context)
                                          ? CustomTextStyle()
                                              .textStyleDesktopBigTitrKcardColorColor
                                          : CustomTextStyle()
                                              .textStyleTabletkCardColorTitr),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: ResponsivePadding()
                                            .largePaddingWidth,
                                        top: ResponsivePadding()
                                            .largePaddingWidth),
                                    child: Image.asset(
                                      color: kCardColor,
                                      HeaderConstantText().logoPath,
                                    ),
                                  ),
                                ])
                          ],
                        ))
              : Responsive.isMobile(context) == false
                  ? AnimatedContainer(
                      duration: Duration(
                          milliseconds: MainPageConstant().headerDuration),
                      curve: Curves.easeIn,
                      width: !sideMenuController.isEndDrawerOpen.value
                          ? Get.width
                          : Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() => basicInfoDashboardController
                                          .basicDashboardInfo[0]
                                          .numberOfUpdateNotes >
                                      0
                                  ? badges.Badge(
                                      position: badges.BadgePosition.topEnd(
                                          top: 0, end: 3),
                                      showBadge: true,
                                      ignorePointer: false,
                                      onTap: () async {
                                        showDialogApiCallBefore(context);
                                        await Network().refreshToken();
                                        await Network()
                                            .getUpdateNotes(
                                                accessToken:
                                                    loginResponseController
                                                        .accesstoken.text)
                                            ?.then((value) {
                                          if (value == false) {
                                            apiCallAfter(context);
                                            Network.showInternetError(
                                                context,
                                                GeneralConstant()
                                                    .apiCallFailureMessage);
                                          } else {
                                            apiCallAfter(context);

                                            showDialogNotes(
                                                context,
                                                basicInfoDashboardController
                                                    .basicDashboardInfo[0]
                                                    .numberOfUpdateNotes);
                                          }
                                        });
                                      },
                                      badgeContent: Text(
                                        basicInfoDashboardController
                                            .basicDashboardInfo[0]
                                            .numberOfUpdateNotes
                                            .toString(),
                                        style: CustomTextStyle()
                                            .textStyleMobileCourierkCardColor,
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
                                        shape: badges.BadgeShape.circle,
                                        badgeColor: kErrorColor,
                                        borderRadius: BorderRadius.circular(4),
                                        elevation: 0,
                                      ),
                                      child: IconButton(
                                        tooltip: NoteConstant().notification,
                                        icon: Icon(Icons.notifications_active,
                                            size: SideMenuConstant().iconSize +
                                                5),
                                        onPressed: () async {
                                          showDialogApiCallBefore(context);
                                          await Network().refreshToken();
                                          await Network()
                                              .getUpdateNotes(
                                                  accessToken:
                                                      loginResponseController
                                                          .accesstoken.text)
                                              ?.then((value) {
                                            if (value == false) {
                                              apiCallAfter(context);
                                              Network.showInternetError(
                                                  context,
                                                  GeneralConstant()
                                                      .apiCallFailureMessage);
                                            } else {
                                              apiCallAfter(context);

                                              showDialogNotes(
                                                  context,
                                                  basicInfoDashboardController
                                                      .basicDashboardInfo[0]
                                                      .numberOfUpdateNotes);
                                            }
                                          });
                                        },
                                      ),
                                    )
                                  : IconButton(
                                      tooltip: NoteConstant().notification,
                                      icon: Icon(Icons.notifications,
                                          size:
                                              SideMenuConstant().iconSize + 5),
                                      onPressed: () async {
                                        showDialogApiCallBefore(context);
                                        await Network().refreshToken();
                                        await Network()
                                            .getUpdateNotes(
                                                accessToken:
                                                    loginResponseController
                                                        .accesstoken.text)
                                            ?.then((value) {
                                          if (value == false) {
                                            apiCallAfter(context);
                                            Network.showInternetError(
                                                context,
                                                GeneralConstant()
                                                    .apiCallFailureMessage);
                                          } else {
                                            apiCallAfter(context);

                                            showDialogNotes(context, 0);
                                          }
                                        });
                                      },
                                    )),
                              PopupMenuButton(
                                tooltip: SideMenuConstant().accountproperties,
                                popUpAnimationStyle: AnimationStyle.noAnimation,
                                color: kPrimaryColor,
                                icon: Icon(
                                  Icons.account_circle_rounded,
                                  color: kCardColor,
                                  size: SideMenuConstant().iconSize + 10,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                        value: 'account',
                                        child: SizedBox(
                                          width: ResponsiveSizedBox()
                                              .middleDistancePopupWidgetwidth,
                                          child: MyTextButtonPoratl(
                                              myicon: Icon(
                                                SideMenuConstant()
                                                    .account['icon'],
                                                size:
                                                    SideMenuConstant().iconSize,
                                                color: kCardColor,
                                              ),
                                              name: SideMenuConstant()
                                                  .account['name'],
                                              function: () async {
                                                AccountsController
                                                    accountController = Get.put(
                                                        AccountsController());

                                                accountController.account
                                                    .clear();
                                                accountController.update();
                                                showDialogApiCallBefore(
                                                    context);
                                                await Network().refreshToken();
                                                await Network()
                                                    .getUser(
                                                        userController:
                                                            userController,
                                                        email: userController
                                                            .username.text)
                                                    .then((value) {
                                                  if (value == false) {
                                                    apiCallAfter(context);
                                                    Network.showInternetError(
                                                        context,
                                                        GeneralConstant()
                                                            .apiCallFailureMessage);
                                                  } else {
                                                    apiCallAfter(context);

                                                    showDialogAccount(context);
                                                  }
                                                });
                                              }),
                                        )),
                                    PopupMenuItem(
                                        value: 'changepassword',
                                        child: SizedBox(
                                            width: ResponsiveSizedBox()
                                                .middleDistancePopupWidgetwidth,
                                            child: MyTextButtonPoratl(
                                              myicon: Icon(
                                                Icons.lock_open,
                                                size:
                                                    SideMenuConstant().iconSize,
                                                color: kCardColor,
                                              ),
                                              name: SideMenuConstant()
                                                  .changePassword['name'],
                                              function: () {
                                                showDialogChangePasword(
                                                    context);
                                              },
                                            ))),
                                    PopupMenuItem(
                                      value: 'exit',
                                      child: SizedBox(
                                        width: ResponsiveSizedBox()
                                            .middleDistancePopupWidgetwidth,
                                        child: MyTextButtonPoratl(
                                          myicon: Icon(
                                            SideMenuConstant().exit['icon'],
                                            size: SideMenuConstant().iconSize,
                                            color: kCardColor,
                                          ),
                                          name: SideMenuConstant().exit['name'],
                                          function: () async {
                                            loginResponseController.logout(0);
                                          },
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                              Obx(
                                () => Padding(
                                  padding: EdgeInsets.only(
                                      left: kDefaultPadding / 2),
                                  child: SlideCountdown(
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        border: Border(
                                            bottom:
                                                BorderSide(color: kCardColor),
                                            top: BorderSide(color: kCardColor)),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    style: Responsive.isDesktop(context)
                                        ? CustomTextStyle()
                                            .textStyleDesktopkCardColor
                                        : CustomTextStyle()
                                            .textStyleTabletkCardColor,
                                    onDone: () {
                                      loginResponseController.logout(400);
                                    },
                                    duration: cornometerController
                                        .timerDuration.value,
                                    durationTitle: DurationTitle.id(),
                                    icon: const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        weight: 0.01,
                                        grade: 1,
                                        applyTextScaling: false,
                                        Icons.alarm,
                                        color: kCardColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(HeaderConstantText().subtitle,
                                    style: Responsive.isDesktop(context)
                                        ? CustomTextStyle()
                                            .textStyleDesktopBigTitrKcardColorColor
                                        : CustomTextStyle()
                                            .textStyleTabletkCardColorTitr),
                                Text(' - ',
                                    style: Responsive.isDesktop(context)
                                        ? CustomTextStyle()
                                            .textStyleDesktopBigTitrKcardColorColor
                                        : CustomTextStyle()
                                            .textStyleTabletkCardColorTitr),
                                Text(HeaderConstantText().title,
                                    style: Responsive.isDesktop(context)
                                        ? CustomTextStyle()
                                            .textStyleDesktopBigTitrKcardColorColor
                                        : CustomTextStyle()
                                            .textStyleTabletkCardColorTitr),
                              ])
                        ],
                      ))
                  : AnimatedContainer(
                      duration: Duration(
                          milliseconds: MainPageConstant().headerDuration),
                      curve: Curves.easeIn,
                      width: !sideMenuController.isEndDrawerOpen.value
                          ? Get.width
                          : Get.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(HeaderConstantText().title,
                                style: CustomTextStyle()
                                    .textStyleTabletkCardColorTitr)
                          ]))),
        ),
        body: Obx(
          () => Row(
            children: [
              Visibility(
                visible: Get.currentRoute == '/reportview' ? true : false,
                child: AnimatedContainer(
                    duration: Duration(
                        milliseconds: MainPageConstant().sideMenuDeuration),
                    curve: Curves.easeIn,
                    width: !sideMenuController.isDrawerOpen.value
                        ? MainPageConstant().openWidthOneSideMenu
                        : MainPageConstant().closeWidthOneSideMenu,
                    child: const EndSideMenu()),
              ),
              AnimatedContainer(
                duration: Duration(
                    milliseconds: MainPageConstant().sideMenuDeuration),
                curve: Curves.easeIn,
                width: Get.currentRoute != '/reportview'
                    ? !sideMenuController.isEndDrawerOpen.value
                        ? MainPageConstant().openWidthOneSideMenuMainPage
                        : MainPageConstant().closeWidthOneSideMenuMainPage
                    : (!sideMenuController.isEndDrawerOpen.value &&
                            !sideMenuController.isDrawerOpen.value)
                        ? MainPageConstant().openWidthBothSideMenuMainPage
                        : (sideMenuController.isEndDrawerOpen.value &&
                                sideMenuController.isDrawerOpen.value)
                            ? MainPageConstant().closeWidthBothSideMenuMainPage
                            : MainPageConstant()
                                .openWidthOneSideMenuMainPageReportView,
                child: body,
              ),
              AnimatedContainer(
                  duration: Duration(
                      milliseconds: MainPageConstant().sideMenuDeuration),
                  curve: Curves.easeIn,
                  width: !sideMenuController.isEndDrawerOpen.value
                      ? MainPageConstant().openWidthOneSideMenu
                      : MainPageConstant().closeWidthOneSideMenu,
                  child: CollapsibleSidebar()),
            ],
          ),
        ),
      ),
    );
  }
}
