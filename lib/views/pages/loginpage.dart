import 'package:deedsuser/controllers/cornometer_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/login_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/updateuser_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/functions/makeUserProperties.dart';
import 'package:deedsuser/models/login_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidget.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetpassword.dart';
import 'package:deedsuser/views/widgets/publicmasterlayout.dart';
import 'package:deedsuser/views/widgets/card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deedsuser/utils/constant.dart';
import 'dart:html';

final cookie = document.cookie;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeData = Theme.of(context);
    UserController userController = Get.put(UserController());
    LoginResponseController loginresponsecontroller =
        Get.put(LoginResponseController());

    return PublicMasterLayout(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: ResponsiveSizedBox().largeDistanceWidgetHeight),
            FullCard(
              title: LoginPageConstantText().mainTitle,
              child: Column(
                children: [
                  SizedBox(
                      width: ResponsiveSizedBox().middleSizeBoxWidth,
                      child: MyTextFormField(
                        hintTitle: LoginPageConstantText().userNameTextField,
                        labelTitle: LoginPageConstantText().userNameTextField,
                        myController: userController.username,
                        alignment: LoginPageConstantText().userNameTextAlign,
                        directionText:
                            LoginPageConstantText().userNameDirection,
                        myicon: LoginPageConstantText().userNameIcon,
                        errorTitle: LoginPageConstantText().userNameError,
                      )),
                  SizedBox(
                      height: ResponsiveSizedBox().smallDistanceWidgetHeight),
                  SizedBox(
                    width: ResponsiveSizedBox().middleSizeBoxWidth,
                    child: MyTextFormFieldPassword(
                      hintTitle: LoginPageConstantText().passwordTextField,
                      labelTitle: LoginPageConstantText().passwordTextField,
                      myController: userController.password,
                      errorTitle: LoginPageConstantText().passwordError,
                      alignment: LoginPageConstantText().passwordTextAlign,
                      directionText: LoginPageConstantText().passwordDirection,
                      myicon: LoginPageConstantText().passwordIcon,
                      secureText: true,
                    ),
                  ),
                  SizedBox(
                      height: ResponsiveSizedBox().smallDistanceWidgetHeight),
                  SizedBox(
                    width: ResponsiveSizedBox().middleSizeBoxWidth,
                    height: ResponsiveSizedBox().middleSizeBoxHeight,
                    child: loginMethod(
                        loginresponsecontroller, userController, context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton loginMethod(LoginResponseController loginresponsecontroller,
      UserController userController, BuildContext context) {
    UpdateUserController updateUserController = Get.put(UpdateUserController());
    ErrorhandelingController errorhandelingController =
        Get.put(ErrorhandelingController());
    CornometerController cornometerController = Get.put(CornometerController());
    bool successLogin = false;
    return ElevatedButton(
        style: Styles().mainStyleButton,
        onPressed: () async {
          // Get.toNamed('/dashboardscreen');
          (userController.username.text.isEmpty ||
                  userController.password.text.isEmpty)
              ? {
                  Get.snackbar(
                    LoginPageConstantText().apiErrorTitle,
                    LoginPageConstantText().apiEmptySubTitle,
                    backgroundColor: kErrorColor.withOpacity(0.7),
                    colorText: kCardColor,
                  )
                }
              : {
                  showDialogApiCallBefore(context),
                  await Network()
                      .login(
                          login: LoginModel(
                              email: userController.username.text,
                              password: userController.password.text,
                              role: 'USER'
                              //  role: 'ADMIN'
                              ))
                      .then((value) async {
                    //   print(value);
                    if (value == false) {
                      apiCallAfter(context);
                      successLogin = false;

                      Get.snackbar(
                        duration: const Duration(seconds: 5),
                        errorhandelingController.errorTitleMessage.value,
                        errorhandelingController.errorSubTitleMessage.value,
                        backgroundColor: kErrorColor.withOpacity(0.7),
                        colorText: kCardColor,
                      );
                    } else {
                      successLogin = true;

                      userController.accesstoken.text =
                          loginresponsecontroller.accesstoken.text;

                      userController.refreshtoken.text =
                          loginresponsecontroller.refreshtoken.text;
                      updateUserController.accesstoken.text =
                          loginresponsecontroller.accesstoken.text;
                      updateUserController.refreshtoken.text =
                          loginresponsecontroller.refreshtoken.text;

                      userController.refreshtoken.text =
                          loginresponsecontroller.refreshtoken.text;
                      userController.update();
                      updateUserController.update();
                      makeUserProperties(userController);
                      Get.put(LoginController()).isLogin = true;
                      Get.put(LoginController()).update();
                      apiCallAfter(context);
                      cornometerController.resetTimeDuration();

                      await Network().allreportbasetcategory(
                          accessToken: userController.accesstoken.text);
                      await Network().getpersonalsetting(
                          email: userController.username.text,
                          accessToken: userController.accesstoken.text);
                      await Network().getBasiInfo(
                          accessToken: userController.accesstoken.text);
                      Get.toNamed('/dashboardscreen');
                    }
                  })
                };
          if (successLogin == true) {}
        },
        child: Text(
          LoginPageConstantText().loginButton,
          style: Responsive.isDesktop(context)
              ? CustomTextStyle().textStyleDesktopkCardColorTitr
              : CustomTextStyle().textStyleTabletkCardColorTitr,
        ));
  }
}
