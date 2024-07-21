import 'dart:async';

import 'package:deedsuser/controllers/accounts_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/updatenote_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/models/accounts_model.dart';
import 'package:deedsuser/models/updatenotes_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidget.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetaddress.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetchangepassword.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetfirstname.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetlastname.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetmobile.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetnewpassword.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetpasswordconfirm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

void showExitConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'هشدار',
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleDesktopKprimaryColorTitr
                    : CustomTextStyle().textStyleTabletKprimaryColorTitr,
              ),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'آیا مطمئن هستید که می‌خواهید این صفحه را ترک کنید؟',
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleDesktopkBlackColor
                    : CustomTextStyle().textStyleTabletkBlackColor,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: Styles().mainStyleButtonToggle,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'خیر',
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleDesktopKprimaryColor
                    : CustomTextStyle().textStyleTabletKprimaryColor,
              ),
            ),
            SizedBox(
              width: Get.width / 10,
            ),
            ElevatedButton(
              style: Styles().mainStyleButton,
              onPressed: () {
                onExit();
              },
              child: Text('بله',
                  style: Responsive.isDesktop(context)
                      ? CustomTextStyle().textStyleDesktopkCardColor
                      : CustomTextStyle().textStyleTabletkCardColor),
            )
          ]);
    },
  );
}

void onExit() {
  LoginResponseController loginResponseController =
      Get.put(LoginResponseController());
  loginResponseController.logout(0);
}

Future<void> showDialogApiCallBefore(BuildContext context) async {
  AlertDialog alert = AlertDialog(
      backgroundColor: kPrimaryColor.withOpacity(0),
      content:
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularProgressIndicator(
          backgroundColor: kCardColor,
          color: kPrimaryColor,
        ),
      ]));
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<void> showDialogApiCallBeforePdf(BuildContext context) async {
  AlertDialog alert = AlertDialog(
      backgroundColor: kErrorColor.withOpacity(0),
      content:
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        LinearProgressIndicator(
          backgroundColor: kCardColor,
        ),
      ]));
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void apiCallAfter(BuildContext context) {
  Navigator.pop(context);
}

Future<void> showDialogAccount(BuildContext context) async {
  UserController userController = Get.put(UserController());
  ErrorhandelingController errorhandelingController =
      Get.put(ErrorhandelingController());
  AccountsController accountController = Get.put(AccountsController());
  LoginResponseController loginResponseController =
      Get.put(LoginResponseController());
  accountController.firstname.text = accountController.account[0].firstname;
  accountController.lastname.text = accountController.account[0].lastname;
  accountController.mobileNumber.text =
      accountController.account[0].mobileNumber;
  accountController.address.text = accountController.account[0].address;

  accountController.gender.text = accountController.account[0].gender;
  accountController.role.text = accountController.account[0].role;
  accountController.mobileNumberobs = accountController.mobileNumber.text.obs;
  accountController.addressobs = accountController.address.text.obs;
  accountController.firstnameobs = accountController.account[0].firstname.obs;
  accountController.lastnameobs = accountController.account[0].lastname.obs;

  accountController.update();
  return showGeneralDialog<void>(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
      context: context,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return AlertDialog(
            scrollable: true,
            title: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      accountController.account.clear();
                      accountController.firstname.text = '';
                      accountController.lastname.text = '';
                      accountController.mobileNumber.text = '';
                      accountController.address.text = '';
                      accountController.mobileNumberobs = ''.obs;
                      accountController.addressobs = ''.obs;
                      accountController.firstnameobs = ''.obs;
                      accountController.lastnameobs = ''.obs;
                      accountController.update();
                      Navigator.of(context).pop(true);
                    },
                    icon: SideMenuConstant().dialog['icon']),
                Text(
                  SideMenuConstant().dialog['name'],
                  style: Responsive.isDesktop(context)
                      ? CustomTextStyle().textStyleDesktopKprimaryColorTitr
                      : CustomTextStyle().textStyleTabletKprimaryColorTitr,
                ),
              ],
            ),
            actions: <Widget>[
              SizedBox(
                  width: ResponsiveSizedBox().middleSizeBoxWidth,
                  height: ResponsiveSizedBox().middleSizeBoxHeight * 1.3,
                  child: Obx(
                    () => Padding(
                      padding: EdgeInsets.all(kDefaultPadding / 2),
                      child: ElevatedButton(
                        style: accountController.validationAccountProp.value ==
                                true
                            ? Styles().mainStyleButton
                            : Styles().disableStyleButton,
                        onPressed: accountController
                                    .validationAccountProp.value ==
                                true
                            ? () async {
                                accountController.account.clear();
                                accountController.update();
                                accountController.accountsSelected
                                    .add(AccountModel(
                                  firstname: accountController.firstname.text,
                                  lastname: accountController.lastname.text,
                                  email:
                                      Get.put(UserController()).username.text,
                                  password: '',
                                  address: accountController.address.text,
                                  mobileNumber:
                                      accountController.mobileNumber.text,
                                  gender: accountController.gender.text,
                                  role: accountController.role.text,
                                  active: true,
                                  hasExcelExport: true,
                                  hasPDFExport: true,
                                  hasChart: true,
                                ));
                                showDialogApiCallBefore(context);
                                await Network().refreshToken();
                                await Network()
                                    .updateUser(
                                        userController: userController,
                                        accountController: accountController)
                                    ?.then((value) async {
                                  apiCallAfter(context);
                                  if (kDebugMode) {
                                    print(value);
                                  }
                                  if (value == true) {
                                    Network.showSuccessCall(context,
                                        SideMenuConstant().updateUserSuccess);
                                    accountController.account.clear();
                                    accountController.firstname.text = '';
                                    accountController.lastname.text = '';
                                    accountController.mobileNumber.text = '';
                                    accountController.address.text = '';
                                    accountController.mobileNumberobs = ''.obs;
                                    accountController.addressobs = ''.obs;
                                    accountController.firstnameobs = ''.obs;
                                    accountController.lastnameobs = ''.obs;
                                    accountController.update();
                                  } else {
                                    errorhandelingController
                                                .errorTitleMessage.value ==
                                            'خطای نشست'
                                        ? await loginResponseController
                                            .logout(401)
                                        : errorhandelingController
                                                    .errorTitleMessage.value ==
                                                'خطای توکن'
                                            ? await loginResponseController
                                                .logout(409)
                                            : Network.showInternetError(
                                                context,
                                                errorhandelingController
                                                    .errorSubTitleMessage
                                                    .value);
                                  }
                                });
                              }
                            : null,
                        child: Text(
                          SideMenuConstant().editAccountButton,
                          style: Responsive.isDesktop(context)
                              ? CustomTextStyle().textStyleDesktopkCardColor
                              : CustomTextStyle().textStyleDesktopkCardColor,
                        ),
                      ),
                    ),
                  ))
            ],
            content: Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    child: MyTextFormField(
                      alignment: TextAlign.left,
                      directionText: TextDirection.ltr,
                      errorTitle: SideMenuConstant().validateUpdateAccount,
                      labelTitle: SideMenuConstant().email['name'],
                      hintTitle: accountController.account[0].email != ''
                          ? accountController.account[0].email
                          : '',
                      myicon: SideMenuConstant().email['icon'],
                      myController: accountController.email,
                      enable: false,
                    ),
                  ),
                  SideMenuConstant().sizedBoxSideMenu,
                  SizedBox(
                    child: MyTextFormFieldFirstName(
                      alignment: TextAlign.right,
                      directionText: TextDirection.rtl,
                      errorTitle: SideMenuConstant().validateUpdateAccount,
                      labelTitle: SideMenuConstant().firstname['name'],
                      hintTitle: '',
                      myicon: SideMenuConstant().firstname['icon'],
                      myController: accountController.firstname,
                    ),
                  ),
                  SideMenuConstant().sizedBoxSideMenu,
                  SizedBox(
                    child: MyTextFormFieldLastName(
                      alignment: TextAlign.right,
                      directionText: TextDirection.rtl,
                      errorTitle: SideMenuConstant().validateUpdateAccount,
                      labelTitle: SideMenuConstant().lastname['name'],
                      hintTitle: '',
                      myicon: SideMenuConstant().lastname['icon'],
                      myController: accountController.lastname,
                    ),
                  ),
                  SideMenuConstant().sizedBoxSideMenu,
                  SizedBox(
                    child: MyTextFormFieldAddress(
                      alignment: TextAlign.right,
                      directionText: TextDirection.rtl,
                      errorTitle: SideMenuConstant().validateUpdateAccount,
                      labelTitle: SideMenuConstant().address['name'],
                      hintTitle: '',
                      myicon: SideMenuConstant().address['icon'],
                      myController: accountController.address,
                    ),
                  ),
                  SideMenuConstant().sizedBoxSideMenu,
                  SizedBox(
                    child: MyTextFormFilterFieldMobile(
                      alignment: TextAlign.left,
                      directionText: TextDirection.ltr,
                      errorTitle: SideMenuConstant().validateUpdateAccount,
                      labelTitle: SideMenuConstant().mobile['name'],
                      hintTitle: '',
                      myicon: SideMenuConstant().mobile['icon'],
                      myController: accountController.mobileNumber,
                    ),
                  ),
                ])));
      });
}

Future<void> showDialogNotes(BuildContext context, int unread) async {
  UpdateNoteController updateNoteController = Get.put(UpdateNoteController());
  LoginResponseController loginResponseController =
      Get.put(LoginResponseController());
  var groupedByVersion = groupBy(updateNoteController.updateNotes,
      (UpdatenotesModel note) => note.version);
  final ScrollController mainScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();
  int index = 0;
  var indexedGroupedByVersion = groupedByVersion.entries.map((entry) {
    return {'index': index++, 'version': entry.key, 'notes': entry.value};
  }).toList();

  return showGeneralDialog<void>(
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        child: child,
      );
    },
    context: context,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () async {
                await Network().getBasiInfo(
                    accessToken: loginResponseController.accesstoken.text);
                Navigator.of(context).pop(true);
              },
              icon: SideMenuConstant().dialog['icon'],
            ),
            Text(NoteConstant().notes['name'],
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleDesktopBigTitrKprimaryColor
                    : CustomTextStyle().textStyleTabletKprimaryColorTitr),
          ],
        ),
        content: Container(
          width: Get.width * 0.2,
          height: Get.height * 0.4,
          child: Scrollbar(
            thumbVisibility: true,
            controller: mainScrollController,
            child: SingleChildScrollView(
              controller: mainScrollController,
              child: Scrollbar(
                thumbVisibility: true,
                controller: horizontalScrollController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: horizontalScrollController,
                  child: Container(
                    width: Get.width * 0.2, // Adjust width as necessary
                    child: Wrap(
                      children: indexedGroupedByVersion.map((group) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right: kDefaultPadding,
                              left: kDefaultPadding,
                              bottom: kDefaultPadding / 2,
                              top: kDefaultPadding / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: Get.width *
                                    0.2, // Adjust width as necessary
                                alignment: Alignment.centerRight,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: kPrimaryColor),
                                    top: BorderSide(color: kPrimaryColor),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(kDefaultPadding / 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SelectableText(
                                        group['version'] as String,
                                        style: Responsive.isDesktop(context)
                                            ? CustomTextStyle()
                                                .textStyleDesktopKprimaryColorTitr
                                            : CustomTextStyle()
                                                .textStyleTabletKprimaryColorTitr,
                                      ),
                                      SelectableText(
                                        NoteConstant().version,
                                        style: Responsive.isDesktop(context)
                                            ? CustomTextStyle()
                                                .textStyleDesktopKprimaryColorTitr
                                            : CustomTextStyle()
                                                .textStyleTabletKprimaryColorTitr,
                                      ),
                                      Icon(
                                        color: int.tryParse(group['index']
                                                    .toString())! <
                                                unread
                                            ? kPrimaryColor
                                            : kPrimaryColor,
                                        int.tryParse(group['index']
                                                    .toString())! <
                                                unread
                                            ? Icons.mark_unread_chat_alt
                                            : Icons.chat_rounded,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ...(group['notes'] as List<UpdatenotesModel>?)!
                                  .map<Widget>((note) => Container(
                                        alignment: Alignment.centerRight,
                                        width: Get.width *
                                            0.2, // Adjust width as necessary
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  kDefaultPadding / 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SelectableText(
                                                    note.description,
                                                    style: Responsive.isDesktop(
                                                            context)
                                                        ? CustomTextStyle()
                                                            .textStyleDesktopkBlackColor
                                                        : CustomTextStyle()
                                                            .textStyleTabletkBlackColor,
                                                    textAlign: TextAlign.right,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                  const Icon(
                                                      Icons.fiber_manual_record,
                                                      color: kBlackColor,
                                                      size: 10),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

//                     Container(
//                       color: i < unread
//                           ? kPrimaryColor.withOpacity(0.7)
//                           : kCardColor,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SelectableText(
//                                 style: i < unread
//                                     ? Responsive.isDesktop(context)
//                                         ? CustomTextStyle()
//                                             .textStyleDesktopkCardColor
//                                         : CustomTextStyle()
//                                             .textStyleDesktopKprimaryColor
//                                     : Responsive.isDesktop(context)
//                                         ? CustomTextStyle()
//                                             .textStyleDesktopKprimaryColor
//                                         : CustomTextStyle()
//                                             .textStyleDesktopkCardColor,
//                                 updateNoteController.updateNotes[i].description
//                                     .toString()),
//                             SelectableText(
//                                 textAlign: TextAlign.left,
//                                 textDirection: TextDirection.ltr,
//                                 style: i < unread
//                                     ? Responsive.isDesktop(context)
//                                         ? CustomTextStyle()
//                                             .textStyleDesktopkCardColor
//                                         : CustomTextStyle()
//                                             .textStyleDesktopKprimaryColor
//                                     : Responsive.isDesktop(context)
//                                         ? CustomTextStyle()
//                                             .textStyleDesktopKprimaryColor
//                                         : CustomTextStyle()
//                                             .textStyleDesktopkCardColor,
//                                 updateNoteController.updateNotes[i].version
//                                     .toString()),
//                             SelectableText(
//                                 style: i < unread
//                                     ? Responsive.isDesktop(context)
//                                         ? CustomTextStyle()
//                                             .textStyleDesktopkCardColor
//                                         : CustomTextStyle()
//                                             .textStyleDesktopKprimaryColor
//                                     : Responsive.isDesktop(context)
//                                         ? CustomTextStyle()
//                                             .textStyleDesktopKprimaryColor
//                                         : CustomTextStyle()
//                                             .textStyleDesktopkCardColor,
//                                 'نسخه'),
//                             Icon(
//                               color: i < unread ? kCardColor : kPrimaryColor,
//                               i < unread
//                                   ? Icons.mark_unread_chat_alt
//                                   : Icons.chat_rounded,
//                               size: 15,
//                             )
//                           ]),
//                     ),
//                     const Divider()
//                   ]
//                 ])));
//       });
// }

Future<void> showDialogChangePasword(BuildContext context) async {
  AccountsController accountController = Get.put(AccountsController());
  ErrorhandelingController errorhandelingController =
      Get.put(ErrorhandelingController());
  accountController.confirmNewPassword.text = '';
  accountController.currentpassowrdobs = '-'.obs;
  accountController.newPassowrdobs = '-'.obs;
  accountController.confirmNewPasswordobs = '-'.obs;
  accountController.newPassword.text = '';
  accountController.currentPassword.text = '';
  accountController.validationAccountProp = false.obs;
  accountController.isPasswordMatch = false.obs;
  accountController.changeAccount = false.obs;
  accountController.currentPasswordNotEmpty = false.obs;
  accountController.newPasswordNotEmpty = false.obs;
  accountController.confirmNewPasswordNotEmpty = false.obs;
  accountController.update();
  LoginResponseController loginResponseController =
      Get.put(LoginResponseController());
  return showGeneralDialog<void>(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
      context: context,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return AlertDialog(
            scrollable: true,
            title: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      accountController.confirmNewPassword.text = '';
                      accountController.currentpassowrdobs = '-'.obs;
                      accountController.newPassowrdobs = '-'.obs;
                      accountController.confirmNewPasswordobs = '-'.obs;
                      accountController.newPassword.text = '';
                      accountController.currentPassword.text = '';
                      accountController.validationAccountProp = false.obs;
                      accountController.isPasswordMatch = false.obs;
                      accountController.changeAccount = false.obs;
                      accountController.currentPasswordNotEmpty = false.obs;
                      accountController.newPasswordNotEmpty = false.obs;
                      accountController.confirmNewPasswordNotEmpty = false.obs;
                      accountController.update();
                      Navigator.of(context).pop(true);
                    },
                    icon: SideMenuConstant().dialog['icon']),
                Text(
                  SideMenuConstant().changePassword['name'],
                  style: Responsive.isDesktop(context)
                      ? CustomTextStyle().textStyleDesktopKprimaryColorTitr
                      : CustomTextStyle().textStyleTabletKprimaryColorTitr,
                ),
              ],
            ),
            actions: <Widget>[
              SizedBox(
                width: ResponsiveSizedBox().middleSizeBoxWidth,
                height: ResponsiveSizedBox().middleSizeBoxHeight * 1.3,
                child: Obx(
                  () => Padding(
                    padding: EdgeInsets.all(kDefaultPadding / 2),
                    child: ElevatedButton(
                      style:
                          accountController.validationPasswordProp.value == true
                              ? Styles().mainStyleButton
                              : Styles().disableStyleButton,
                      onPressed:
                          accountController.validationPasswordProp.value == true
                              ? () async {
                                  await Network().refreshToken();
                                  await Network()
                                      .changePassword(
                                          currentPassword: accountController
                                              .currentPassword.text,
                                          newPassword: accountController
                                              .newPassword.text,
                                          accessToken: loginResponseController
                                              .accesstoken.text)
                                      ?.then((value) async {
                                    if (kDebugMode) {
                                      print(value);
                                    }
                                    if (value == true) {
                                      await loginResponseController.logout(200);
                                    } else {
                                      Network.showInternetError(
                                          context,
                                          errorhandelingController
                                              .errorSubTitleMessage.value);
                                    }
                                  });
                                }
                              : null,
                      child: Text(
                        SideMenuConstant().editAccountButton,
                        style: Responsive.isDesktop(context)
                            ? CustomTextStyle().textStyleDesktopkCardColor
                            : CustomTextStyle().textStyleDesktopkCardColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            content: Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    child: MyTextFormFieldChangePassword(
                      alignment: TextAlign.left,
                      directionText: TextDirection.ltr,
                      errorTitle:
                          ChangePasswordConstantText().currentPasswordError,
                      labelTitle: SideMenuConstant().currentPassword['name'],
                      hintTitle:
                          ChangePasswordConstantText().currentPasswordTextField,
                      myicon: SideMenuConstant().currentPassword['icon'],
                      myController: accountController.currentPassword,
                    ),
                  ),
                  SizedBox(
                      height: ResponsiveSizedBox().smallDistanceWidgetHeight),
                  SizedBox(
                    child: MyTextFormFieldNewPassword(
                      alignment: TextAlign.left,
                      directionText: TextDirection.ltr,
                      errorTitle: ChangePasswordConstantText().newPasswordError,
                      labelTitle: SideMenuConstant().newPassword['name'],
                      hintTitle:
                          ChangePasswordConstantText().newPasswordTextField,
                      myicon: SideMenuConstant().newPassword['icon'],
                      myController: accountController.newPassword,
                    ),
                  ),
                  SizedBox(
                      height: ResponsiveSizedBox().smallDistanceWidgetHeight),
                  SizedBox(
                    child: MyTextFormFieldPasswordConfrim(
                      newPassword: accountController.newPassword.text,
                      alignment: TextAlign.left,
                      directionText: TextDirection.ltr,
                      errorTitle: ChangePasswordConstantText()
                          .confirmPasswordEmptyError,
                      labelTitle: SideMenuConstant().confirmPassword['name'],
                      hintTitle:
                          ChangePasswordConstantText().confirmPasswordTextField,
                      myicon: SideMenuConstant().confirmPassword['icon'],
                      myController: accountController.confirmNewPassword,
                    ),
                  ),
                  Obx(() {
                    if (!accountController.isPasswordMatch.value &&
                        accountController
                            .confirmNewPasswordobs.value.isNotEmpty &&
                        accountController.confirmNewPassword != '') {
                      return SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: kDefaultPadding,
                              left: kDefaultPadding,
                              right: kDefaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.left,
                                ChangePasswordConstantText()
                                    .confirmPasswordError,
                                style: Responsive.isDesktop(context)
                                    ? CustomTextStyle()
                                        .textStyleDesktopKerrorColor
                                    : CustomTextStyle()
                                        .textStyleTabletKerrorColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                ])));
      });
}
